Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUBLB4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUBLB4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:56:33 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:5903 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265754AbUBLB4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:56:31 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1076550429@astro.swin.edu.au>
Subject: BUG related to Zip device and ppa (2.6.2-rc2)
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-22180-9689-200402121247-tc@hexane.ssi.swin.edu.au>
Date: Thu, 12 Feb 2004 12:56:29 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux bohr 2.6.2-rc2 #2 Sun Feb 1 18:59:26 EST 2004 i586 GNU/Linux

I got this mail, which seems to be timed to when I last umounted my
zip drive. I recall having slight problems mounting the device,
possibly since I had unplugged it a few times previously, and had to
rmmod all things related to the parallel port - parport, parport_pc,
lp, ppa, before modprobing ppa again.

Subject: Oops or BUG detected at Feb 12 10:20:55

Feb 12 10:20:55 bohr kernel: Badness in interruptible_sleep_on at kernel/sched.c:1919
Feb 12 10:20:55 bohr kernel: Call Trace:
Feb 12 10:20:55 bohr kernel:  [interruptible_sleep_on+209/224] interruptible_sleep_on+0xd1/0xe0
Feb 12 10:20:55 bohr kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Feb 12 10:20:55 bohr kernel:  [__crc_serio_rescan+4743609/6417717] ppa_wakeup+0x19/0x60 [ppa]
Feb 12 10:20:55 bohr kernel:  [__crc_serio_rescan+6091072/6417717] parport_claim_or_block+0x40/0x60 [parport]
Feb 12 10:20:55 bohr kernel:  [__crc_serio_rescan+4986873/6417717] lp_write+0x319/0x380 [lp]
Feb 12 10:20:55 bohr kernel:  [vfs_write+138/224] vfs_write+0x8a/0xe0
Feb 12 10:20:55 bohr kernel:  [sys_write+44/96] sys_write+0x2c/0x60
Feb 12 10:20:55 bohr kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 12 10:20:55 bohr kernel: 
Feb 12 10:21:19 bohr leafnodeupdate[5041]: connect from 192.168.1.2


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
SIGTHTBABW: a signal sent from Unix to its programmers at random
intervals to make them remember that There Has To Be A Better Way.
