Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRGWXep>; Mon, 23 Jul 2001 19:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264933AbRGWXef>; Mon, 23 Jul 2001 19:34:35 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:35231 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S264958AbRGWXeZ>; Mon, 23 Jul 2001 19:34:25 -0400
Date: Tue, 24 Jul 2001 01:34:30 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: Oops when trying to reboot
Message-ID: <20010724013430.A29741@flodhest.stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

I've compiled a 2.4.6 kernel (with aacraid-patches, and hidden-patch for
lvs), and everytime I try to reboot a box with the kernel, it does an oops
on me. I need to go and reset the damn box by hand afterwards.

This is the oops through ksymoops:

ksymoops 2.4.0 on i686 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
83c88804
*pde = 00000000
Oops: 0000
CPU:     1
EIP:     0010:[<83c88804>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010282
eax: 000000000  ebx: f883eaa4  ecx: 000e1898  edx: 00000000
esi: 000000000  edi: 00000001  ebp: bffffcb8  esp: f6be3e8c
ds: 0018  es: 0018  ss: 0018
Process reboot (pid: 1245, stackpage=f6be3000)
Stack: c011d375 f883eaa4 00000001 00000000 f6be2000 f6be2000 fee1dead c011d701
       c0307d44 00000001 00000000 f6dbf760 400f4ef0 00000000 f6c903d0 f6be3f3d
       f6be3f2c f6be2000 c023daa9 00000292 f6e2b7e0 00000020 30687465 00000000
Call trace: [<c011d375>] [<c011d701>] [<c023daa9>] [<c01f9357>] [<c0238f43>]
[<c0148100>] [<c0146e3c>]
       [<c0134257>] [<c0133114>] [<c013317b>] [<c0106ffb>]
Code: Bad EIP value.

>>EIP; 83c88804 Before first symbol   <=====
Trace; c011d375 <notifier_call_chain+25/50>
Trace; c011d701 <sys_reboot+f1/290>
Trace; c023daa9 <vsprintf+349/380>
Trace; c01f9357 <sk_free+37/40>
Trace; c0238f43 <unx_marshal+83/140>
Trace; c0148100 <destroy_inode+30/40>
Trace; c0146e3c <dput+1c/160>
Trace; c0134257 <fput+77/e0>
Trace; c0133114 <filp_close+a4/b0>
Trace; c013317b <sys_close+5b/70>
Trace; c0106ffb <system_call+33/38>


2 warnings issued.  Results may not be reliable.


Any ideas what's wrong?

-- 
Thomas
