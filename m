Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSCaA3F>; Sat, 30 Mar 2002 19:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSCaA24>; Sat, 30 Mar 2002 19:28:56 -0500
Received: from [62.189.41.121] ([62.189.41.121]:11012 "EHLO
	getyour.pawsoff.org") by vger.kernel.org with ESMTP
	id <S293722AbSCaA2g>; Sat, 30 Mar 2002 19:28:36 -0500
From: Kieran Fulke <kieran@getyour.pawsoff.org>
Message-Id: <200203310032.g2V0WauV006887@getyour.pawsoff.org>
Subject: Oops - 2.4.18 MegaRaid/Alpha (ksymoops)
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Mar 2002 00:32:36 +0000 (UTC)
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

at the excellent suggestion of Mr Keith Owens, I ran it theough ksymoops. enjoy :)


ksymoops 2.4.3 on alpha 2.4.18-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfs/ (default)
     -m /boot/System.map-2.4.18-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol sysctl_unix_max_dgram_qlen  , unix says fffffffc00245e50, /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o says 
fffffffc00240000.  Ignoring /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o entry
Warning (compare_maps): mismatch on symbol unix_table_lock  , unix says fffffffc00245e54, /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o says fffffffc00240004.  
Ignoring /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o entry
Warning (compare_maps): mismatch on symbol unix_tot_inflight  , unix says fffffffc00245e68, /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o says fffffffc00240018.  
Ignoring /lib/modules/2.4.18-xfs/kernel/net/unix/unix.o entry
Mar 30 23:58:44 kleptomania kernel: modprobe(211): Oops 0
Mar 30 23:58:44 kleptomania kernel: pc = [<fffffffc00277cb0>]  ra = [<fffffffc002789d8>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
Mar 30 23:58:44 kleptomania kernel: v0 = 000000009dea0670  t0 = 000000009dea0670  t1 = ffffffff9deb6010
Mar 30 23:58:44 kleptomania kernel: t2 = fffffc001df3bb97  t3 = fffffc001df3bb8b  t4 = 00000000000f00a1
Mar 30 23:58:44 kleptomania kernel: t5 = fffffc001df3bb88  t6 = 0000000000000000  t7 = fffffc001df38000
Mar 30 23:58:44 kleptomania kernel: s0 = 000000001deb6010  s1 = fffffc001df3bb88  s2 = 000000001deb6010
Mar 30 23:58:44 kleptomania kernel: s3 = 0000000000000000  s4 = fffffc001dea00c0  s5 = 000000001deb601f
Mar 30 23:58:44 kleptomania kernel: s6 = 0000000000000000
Mar 30 23:58:44 kleptomania kernel: a0 = fffffc001dea00c0  a1 = fffffc001df3bb88  a2 = 0000000000000000
Mar 30 23:58:44 kleptomania kernel: a3 = 0000000000000000  a4 = fffffc001dea00c0  a5 = fffffc0000acdfc0
Mar 30 23:58:44 kleptomania kernel: t8 = 0000000000000000  t9 = fffffc0000a28a80  t10= fffffc001ff0d000
Mar 30 23:58:44 kleptomania kernel: t11= 000000000000000a  pv = fffffc000081c380  at = fffffc0000acdfd8
Mar 30 23:58:44 kleptomania kernel: gp = fffffffc00286f30  sp = fffffc001df3bad8
Mar 30 23:58:44 kleptomania kernel: Trace:fffffc000084ad00 fffffc000081c010 fffffc000099b24c fffffc000099c9d8 fffffc00008257d8 fffffc000084b468 fffffc0000825a0c 
fffffc0000810b20
Mar 30 23:58:44 kleptomania kernel: Code: a04d0018  4161f40e  b45e0050  2fe00000  47ff041f  2fe00000 <2c2b000f> 47ff041f

>>PC;  fffffffc00277cb0 <[megaraid]megaIssueCmd+f0/600>   <=====
Trace; fffffc000084ad00 <__alloc_pages+80/240>
Trace; fffffc000081c010 <pci_alloc_consistent+d0/120>
Trace; fffffc000099b24c <scsi_register_host+cc/4a0>
Trace; fffffc000099c9d8 <scsi_register_module+58/c0>
Trace; fffffc00008257d8 <sys_init_module+758/ae0>
Trace; fffffc000084b468 <free_pages+68/80>
Trace; fffffc0000825a0c <sys_init_module+98c/ae0>
Trace; fffffc0000810b20 <entSys+a8/c0>
Code;  fffffffc00277c98 <[megaraid]megaIssueCmd+d8/600>
0000000000000000 <_PC>:
Code;  fffffffc00277c98 <[megaraid]megaIssueCmd+d8/600>
   0:   18 00 4d a0       ldl  t1,24(s4)
Code;  fffffffc00277c9c <[megaraid]megaIssueCmd+dc/600>
   4:   0e f4 61 41       addq s2,0xf,s5
Code;  fffffffc00277ca0 <[megaraid]megaIssueCmd+e0/600>
   8:   50 00 5e b4       stq  t1,80(sp)
Code;  fffffffc00277ca4 <[megaraid]megaIssueCmd+e4/600>
   c:   00 00 e0 2f       unop
Code;  fffffffc00277ca8 <[megaraid]megaIssueCmd+e8/600>
  10:   1f 04 ff 47       nop
Code;  fffffffc00277cac <[megaraid]megaIssueCmd+ec/600>
  14:   00 00 e0 2f       unop
Code;  fffffffc00277cb0 <[megaraid]megaIssueCmd+f0/600>   <=====
  18:   0f 00 2b 2c       ldq_u        t0,15(s2)   <=====
Code;  fffffffc00277cb4 <[megaraid]megaIssueCmd+f4/600>
  1c:   1f 04 ff 47       nop


4 warnings issued.  Results may not be reliable.

