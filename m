Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCHSQf>; Thu, 8 Mar 2001 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCHSQ0>; Thu, 8 Mar 2001 13:16:26 -0500
Received: from relay2.inwind.it ([212.141.53.73]:45462 "EHLO relay2.inwind.it")
	by vger.kernel.org with ESMTP id <S129464AbRCHSQR>;
	Thu, 8 Mar 2001 13:16:17 -0500
Date: Thu, 8 Mar 2001 19:15:48 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: OOPS with 2.4.2-ac12
Message-ID: <20010308191548.A392@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've been experiencing since 2.4.2-ac5 (I'm not sure about this) some
oops on one of my PCs: it's a Pentium Classic 166, 84 MB of RAM, kernel
2.4.2-ac12.

It works as a gateway (doing NAT) between my LAN and internet. I use a
ISDN card (Hisax HFC-PCI) and a NE2000 compatible nic (ne.c). I can't
reproduce the error, sometimes the box stays up without problems,
sometimes it crash a few minutes after rebooting.

I attach the ooops I get (written down by hand) decoded using ksymoops.

Gianluca

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="output.txt"

ksymoops 2.3.4 on i586 2.4.2-ac12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac12/ (default)
     -m /boot/System.map-2.4.2-ac12 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0
eip: 0010:[<c0126de6>]
Using defaults from ksymoops -t elf32-i386 -a i386
eflags: 00010246
eax: 00001000 ebx: 00000000 ecx: 00001000 edx:00000000
esi: c4d876c0 edi: c4d10b80 ebp: 00000050 esp: c020bde8
ds: 00180  es: 00180  ss: 0018
Process Swapper (pid: 0, stackpage=c020b000)
Stack: c019440d ffffff00 c4d876c0 c019494b c4d876c0 c4d876c0 c58362a0 c3f711a0
       c58362a0 c0197713 c4d876c0 00000002 c2eef200 c4d876c0 c019a713 c4d876c0
       c4d876c0 00000000 00000004 c01a462c c01a46a5 c4d876c0 00000001 c58362a0
Call Trace: c019440d c019494b c58362a0 c58362a0 c0197713 c019a713 c01a462c
            c01a46a5 c58362a0 c019c742 c58362a0 c01a1ddc c01a4612 c58362a0 c01a462c
            c58362a0 c01a1e2a c019c742 c58362a0 c01a05dc c01a1d89 c58362a0 c01a1ddc
            c01a10b8 c01a1219 c01a10b8 c019c742 c01a0f26 c01a10b8 c0197c6d c0115c70
            c010a131 c0107120 c0108e20 c0107120 c0107143 c01071a7 c0105000 c0100191
Code: 8b 41 18 85 c0 7c 11 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e8

>>EIP; c0126de6 <__free_pages+2/1c>   <=====
Trace; c019440d <skb_release_data+41/74>
Trace; c019494b <skb_linearize+7f/e0>
Trace; c58362a0 <[ne]__module_kernel_version+0/0>
Trace; c58362a0 <[ne]__module_kernel_version+0/0>
Trace; c0197713 <dev_queue_xmit+67/1e8>
Trace; c019a713 <neigh_resolve_output+103/174>
Trace; c01a462c <ip_finish_output2+0/b4>
Code;  c0126de6 <__free_pages+2/1c>
00000000 <_EIP>:
Code;  c0126de6 <__free_pages+2/1c>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c0126de9 <__free_pages+5/1c>
   3:   85 c0                     test   %eax,%eax
Code;  c0126deb <__free_pages+7/1c>
   5:   7c 11                     jl     18 <_EIP+0x18> c0126dfe <__free_pages+1a/1c>
Code;  c0126ded <__free_pages+9/1c>
   7:   ff 49 14                  decl   0x14(%ecx)
Code;  c0126df0 <__free_pages+c/1c>
   a:   0f 94 c0                  sete   %al
Code;  c0126df3 <__free_pages+f/1c>
   d:   84 c0                     test   %al,%al
Code;  c0126df5 <__free_pages+11/1c>
   f:   74 07                     je     18 <_EIP+0x18> c0126dfe <__free_pages+1a/1c>
Code;  c0126df7 <__free_pages+13/1c>
  11:   89 c8                     mov    %ecx,%eax
Code;  c0126df9 <__free_pages+15/1c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0126dfe <__free_pages+1a/1c>


1 warning issued.  Results may not be reliable.

--zYM0uCDKw75PZbzx--
