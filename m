Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSFTSma>; Thu, 20 Jun 2002 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFTSm3>; Thu, 20 Jun 2002 14:42:29 -0400
Received: from server1.mpc.com.br ([200.246.0.242]:28683 "EHLO
	server1.mpc.com.br") by vger.kernel.org with ESMTP
	id <S315375AbSFTSm2>; Thu, 20 Jun 2002 14:42:28 -0400
Date: Thu, 20 Jun 2002 15:42:17 -0300
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10 Oops
Message-ID: <20020620184217.GA4077@mpcnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: pellegrini@mpcnet.com.br (Jeronimo Pellegrini)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Got an Oops a few minutes ago with plain 2.4.19-pre10, compiled for
Athlon/K7. If you need more info, tell me!

J.


ksymoops 2.4.5 on i686 2.4.19-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre10/ (default)
     -m /boot/System.map-2.4.19-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun 20 15:15:56 localhost kernel: Unable to handle kernel paging request at virtual address 10854a66
Jun 20 15:15:56 localhost kernel: bfa95f90
Jun 20 15:15:56 localhost kernel: *pde = 00000000
Jun 20 15:15:56 localhost kernel: Oops: 0002
Jun 20 15:15:56 localhost kernel: CPU:    0
Jun 20 15:15:56 localhost kernel: EIP:    0010:[<bfa95f90>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 20 15:15:56 localhost kernel: EFLAGS: 00010202
Jun 20 15:15:56 localhost kernel: eax: 10854a66   ebx: c38d6c40   ecx: c38d6000   edx: 10854a66
Jun 20 15:15:56 localhost kernel: esi: cffe8800   edi: ca7ae000   ebp: 00000002   esp: c3e4be90
Jun 20 15:15:56 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jun 20 15:15:56 localhost kernel: Process ps (pid: 10617, stackpage=c3e4b000)
Jun 20 15:15:56 localhost kernel: Stack: c01460de c38d6c40 00004300 c014e955 00004300 ca7ae000 c543f640 c543f640
Jun 20 15:15:56 localhost kernel:        c014efd4 cffe8800 ca7ae000 00000002 c12ce440 c543f640 c543f640 c12cd1c0
Jun 20 15:15:56 localhost kernel:        ffffffff c543f6a1 c014dc49 c12ce440 c543f640 fffffff4 c12ce440 c013c7e3
Jun 20 15:15:56 localhost kernel: Call Trace: [get_empty_inode+142/160] [proc_pid_make_inode+21/192] [proc_pid_lookup+356/464] [proc_root_lookup+57/80] [real_lookup+83/192]
Jun 20 15:15:56 localhost kernel: Code:  Bad EIP value.


>>EIP; bfa95f90 Before first symbol   <=====

>>eax; 10854a66 Before first symbol
>>ebx; c38d6c40 <_end+358919c/1050a55c>
>>ecx; c38d6000 <_end+358855c/1050a55c>
>>edx; 10854a66 Before first symbol
>>esi; cffe8800 <_end+fc9ad5c/1050a55c>
>>edi; ca7ae000 <_end+a46055c/1050a55c>
>>esp; c3e4be90 <_end+3afe3ec/1050a55c>


1 warning issued.  Results may not be reliable.

--
