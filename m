Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSD2UpI>; Mon, 29 Apr 2002 16:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSD2UpH>; Mon, 29 Apr 2002 16:45:07 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:2776 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315198AbSD2UpG>; Mon, 29 Apr 2002 16:45:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: James Simmons <jsimmons@transvirtual.com>
Subject: 2.5.11 framebuffer kernel panic 
Date: Mon, 29 Apr 2002 14:38:25 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10204291056490.15166-100000@www.transvirtual.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        LFB <linux-fbdev-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <02042914382500.00843@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, here's the result of my first 2.5 compiled kernel :
Codes were hand-copied. Inaccuracy is possible but unlikely.
I checked several times. 
----------------------------------------------------------------

ksymoops 2.4.0 on i686 2.4.19-pre3.  Options used
     -v /usr/src/linux-2.5.11/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.11 (specified)
     -m /boot/System.map-2.5.11 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 000001b4
*pde = 00000000
oops: 0000
CPU: 0
EIP: 0010: [<c02055f6>] Not tainted.
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: c0336570 ebx: 00007f80 ecx: 00000000
esi: 00000000 edi: 00000180 ebp: 00000000 esp: d3eefce8
ds: 0018 es: 0018 ss: 0018
Stack: 00007f80 c0336680 c1313800 00000000 c0203a70 c0336570 00000002 00000000
       00000180 00000003 c02b48f4 c02b4a60 00000206 00000003 00000246 c012f69f
       c02b48f4 c02b4a5c 000001f0 00000000 c12d79c0 000001f0 c1308000 c012d39e
Call Trace: [<c0203a70>] [<c012f69f>] [<c012d39f>] [<c01ff424>] [<c0200990>]
            [<c01ba4a9>] [<c01fef53>] [<c01fe603>] [<c01ba5de>] [<c01be0ed>]
            [<c01fd91a>] [<c0105000>] [<c0105070>] [<c0105000>] [<c0105646>]
            [<c0105050>]
Code: 8b 9d b4 01 00 00 85 db 0f 84 ac 00 00 00 0f b7 82 02 01 00

>>EIP; c02055f6 <atyfb_cursor+16/e0>   <=====
Trace; c0203a70 <atyfbcon_switch+70/e0>
Trace; c012f69f <__alloc_pages+3f/180>
Trace; c012d39f <kmem_cache_grow+ef/270>
Trace; c01ff424 <fbcon_cursor+b4/1e0>
Trace; c0200990 <fbcon_switch+140/1c0>
Trace; c01ba4a9 <redraw_screen+c9/140>
Trace; c01fef53 <fbcon_setup+843/940>
Trace; c01fe603 <fbcon_init+b3/e0>
Trace; c01ba5de <visual_init+9e/100>
Trace; c01be0ed <take_over_console+ad/180>
Trace; c01fd91a <register_framebuffer+fa/130>
Trace; c0105000 <_stext+0/0>
Trace; c0105070 <init+20/180>
Trace; c0105000 <_stext+0/0>
Trace; c0105646 <kernel_thread+26/30>
Trace; c0105050 <init+0/180>
Code;  c02055f6 <atyfb_cursor+16/e0>
00000000 <_EIP>:
Code;  c02055f6 <atyfb_cursor+16/e0>   <=====
   0:   8b 9d b4 01 00 00         mov    0x1b4(%ebp),%ebx   <=====
Code;  c02055fc <atyfb_cursor+1c/e0>
   6:   85 db                     test   %ebx,%ebx
Code;  c02055fe <atyfb_cursor+1e/e0>
   8:   0f 84 ac 00 00 00         je     ba <_EIP+0xba> c02056b0 
<atyfb_cursor+d0/e0>
Code;  c0205604 <atyfb_cursor+24/e0>
   e:   0f b7 82 02 01 00 00      movzwl 0x102(%edx),%eax

<0> Kernel panic: Attempted to kill Init!
