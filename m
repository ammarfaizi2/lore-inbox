Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSINWuC>; Sat, 14 Sep 2002 18:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSINWuC>; Sat, 14 Sep 2002 18:50:02 -0400
Received: from mail.uklinux.net ([80.84.72.21]:17682 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S317597AbSINWuB>;
	Sat, 14 Sep 2002 18:50:01 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Sat, 14 Sep 2002 23:53:16 +0100
From: Mark Hindley <mark@hindley.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.19
Message-ID: <20020914235316.A768@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii

I have been getting recurrent lockup over the past few days. Just managed to catch an oops on a serial console. See,s to happen a while (20mins to 4 hours) after the system is idle. Alt-SysRq usually unresponsive. Hard reset is only way out.

oops passed though ksymoops is below. Let me know if other info would be useful.

Thanks


Mark
-- 


--EeQfGwPcQSOJBaQU
Content-Type: text/plain
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.3.7 on i586 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (specified)

Sep 14 20:10:11 titan kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 14 20:10:11 titan kernel: c01099c2
Sep 14 20:10:11 titan kernel: *pde = 00000000
Sep 14 20:10:11 titan kernel: Oops: 0000
Sep 14 20:10:11 titan kernel: CPU:    0
Sep 14 20:10:11 titan kernel: EIP:    0010:[do_IRQ+106/168]    Not tainted
Sep 14 20:10:11 titan kernel: EFLAGS: 00010046
Sep 14 20:10:11 titan kernel: eax: 20000001   ebx: 00000000   ecx: c024bc88   edx: c0252a80
Sep 14 20:10:11 titan kernel: esi: 00000000   edi: 00000000   ebp: c3b33f88   esp: c3b33f6c
Sep 14 20:10:11 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 14 20:10:11 titan kernel: Process hopalong (pid: 4753, stackpage=c3b33000)
Sep 14 20:10:11 titan kernel: Stack: 00000000 c3b33f90 c0202684 c1f3b9a0 00000002 00000003 c0202684 bffff5ec 
Sep 14 20:10:11 titan kernel:        c010bad8 c1f3b9a0 00000000 c3b32000 00000002 00000003 bffff5ec 00000000 
Sep 14 20:10:11 titan kernel:        00000018 00000018 ffffff00 c01085a0 00000010 00000246 00000003 bffff6a4 
Sep 14 20:10:11 titan kernel: Call Trace:    [call_do_IRQ+5/13] [ret_from_sys_call+0/17]
Sep 14 20:10:11 titan kernel: Code: 8b 46 00 83 c4 0c a8 04 74 07 24 fb 89 46 00 eb e1 80 66 00 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 46 00                  mov    0x0(%esi),%eax
Code;  00000003 Before first symbol
   3:   83 c4 0c                  add    $0xc,%esp
Code;  00000006 Before first symbol
   6:   a8 04                     test   $0x4,%al
Code;  00000008 Before first symbol
   8:   74 07                     je     11 <_EIP+0x11> 00000011 Before first symbol
Code;  0000000a Before first symbol
   a:   24 fb                     and    $0xfb,%al
Code;  0000000c Before first symbol
   c:   89 46 00                  mov    %eax,0x0(%esi)
Code;  0000000f Before first symbol
   f:   eb e1                     jmp    fffffff2 <_EIP+0xfffffff2> fffffff2 <END_OF_CODE+3b6a5093/????>
Code;  00000011 Before first symbol
  11:   80 66 00 00               andb   $0x0,0x0(%esi)

00000000 <_EIP>:

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=uname

Linux titan.home.hindley.uklinux.net 2.4.19 #4 Tue Aug 27 11:07:59 BST 2002 i586 unknown

--EeQfGwPcQSOJBaQU--
