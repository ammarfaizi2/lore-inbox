Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273093AbRIQDV2>; Sun, 16 Sep 2001 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273462AbRIQDVJ>; Sun, 16 Sep 2001 23:21:09 -0400
Received: from gwyn.tux.org ([207.96.122.8]:59052 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S273093AbRIQDVA>;
	Sun, 16 Sep 2001 23:21:00 -0400
Date: Sun, 16 Sep 2001 23:21:24 -0400
From: Timothy Ball <timball@tux.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk
Subject: oops w/ 2.4.9-ac9 keventd
Message-ID: <20010916232124.S22190@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the oops stuff: 

--snip--snip--snip--
CPU:    0
EIP:    0010:[<c01d6560>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000283
eax: 0000002c   ebx: 000040d8   ecx: 7509b28b   edx: 00000074
esi: 00000af8   edi: ffffffff   ebp: c027e0c0   esp: c1249f3c
ds: 0018   es: 0018   ss: 0018
Process keventd (pid: 2, stackpage=c1249000)
Stack: 00196000 c01d65a7 000040d8 c01d6612 000040d8 00000006 c0198e39 00068d58 
       c027e0c0 c1249fa4 c124823a c1248000 c1240540 05c0823a c0198eb4 c027e0c0 
       00000ef8 c027e0c0 c0198f43 c027e0c0 00000ef8 c027e188 c0116364 c027e0c0 
Call Trace: [<c01d65a7>] [<c01d6612>] [<c0198e39>] [<c0198eb4>] [<c0198f43>] 
   [<c0116364>] [<c011ccad>] [<c010545c>] 
Code: f3 90 0f 31 29 c8 39 d8 72 f6 5b c3 8b 44 24 04 eb 0e 8d b4 

>>EIP; c01d6560 <__rdtsc_delay+10/1c>   <=====
Trace; c01d65a6 <__delay+12/28>
Trace; c01d6612 <__const_udelay+22/30>
Trace; c0198e38 <yenta_probe_irq+a8/100>
Trace; c0198eb4 <yenta_get_socket_capabilities+24/4c>
Trace; c0198f42 <yenta_open_bh+66/88>
Trace; c0116364 <__run_task_queue+4c/60>
Trace; c011ccac <context_thread+110/194>
Trace; c010545c <kernel_thread+28/38>
Code;  c01d6560 <__rdtsc_delay+10/1c>
00000000 <_EIP>:
Code;  c01d6560 <__rdtsc_delay+10/1c>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c01d6562 <__rdtsc_delay+12/1c>
   2:   0f 31                     rdtsc  
Code;  c01d6564 <__rdtsc_delay+14/1c>
   4:   29 c8                     sub    %ecx,%eax
Code;  c01d6566 <__rdtsc_delay+16/1c>
   6:   39 d8                     cmp    %ebx,%eax
Code;  c01d6568 <__rdtsc_delay+18/1c>
   8:   72 f6                     jb     0 <_EIP>
Code;  c01d656a <__rdtsc_delay+1a/1c>
   a:   5b                        pop    %ebx
Code;  c01d656a <__rdtsc_delay+1a/1c>
   b:   c3                        ret    
Code;  c01d656c <__loop_delay+0/28>
   c:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c01d6570 <__loop_delay+4/28>
  10:   eb 0e                     jmp    20 <_EIP+0x20> c01d6580 <__loop_delay+1
4/28>
Code;  c01d6572 <__loop_delay+6/28>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi
--snip--snip--snip--

Output form ver_linux
--snip--snip--snip--
Linux kundera 2.4.9-ac9 #1 Sun Sep 16 03:51:13 EDT 2001 i586 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.8
e2fsprogs              1.24a
pcmcia-cs              3.1.22
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         prism2_cs p80211 floppy apm smbfs sb sb_lib uart401 sound nfs lockd sunrpc
--snip--snip--snip--

The hardware is my little laptop, it's a slimnote 9T notebook running
debian sid (unstable). pentium 166 w/ 128M of ram...

I hope this is useful to someone, let me know if I can be a help.

--timball

-- 
	GPG key available on pgpkeys.mit.edu
pub  1024R/CFF85605 1999-06-10 Timothy L. Ball <timball@sheergenius.com>
     Key fingerprint = 8A 8E 64 D6 21 C0 90 29  9F D6 1E DC F8 18 CB CD
