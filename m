Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVBSMdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVBSMdT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 07:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVBSMdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 07:33:19 -0500
Received: from smtp.sws.net.au ([61.95.69.6]:48042 "EHLO smtp.sws.net.au")
	by vger.kernel.org with ESMTP id S261702AbVBSMdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 07:33:08 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: linux-kernel@vger.kernel.org
Subject: idr_remove
Date: Sat, 19 Feb 2005 23:32:52 +1100
User-Agent: KMail/1.7.2
Cc: Jim Houston <jim.houston@ccur.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2HzFC8NAih2IRxV"
Message-Id: <200502192332.54815.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2HzFC8NAih2IRxV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

http://marc.theaimsgroup.com/?l=linux-kernel&m=109838483518162&w=2

I am getting messages "idr_remove called for id=0 which is not allocated" when 
SE Linux denies search access to /dev/pts.

The attached file has some klogd output showing the situation, triggered in 
this case by installing a new kernel package on a SE Debian system.  The 
above URL references Jim Houston's message with the patch to add this 
warning.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_2HzFC8NAih2IRxV
Content-Type: text/plain;
  charset="us-ascii";
  name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log"

Jan 17 13:45:43 lyta kernel: audit(1105929943.164:0): avc:  denied  { search } for  pid=30322 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.347:0): avc:  denied  { search } for  pid=30322 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.425:0): avc:  denied  { search } for  pid=30328 exe=/usr/bin/stat name=run dev=dm-2 ino=597921 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:var_run_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.486:0): avc:  denied  { search } for  pid=30328 exe=/usr/bin/stat name=run dev=dm-2 ino=597921 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:var_run_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.563:0): avc:  denied  { search } for  pid=30333 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.713:0): avc:  denied  { search } for  pid=30333 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.785:0): avc:  denied  { search } for  pid=30337 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.902:0): avc:  denied  { search } for  pid=30337 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: audit(1105929943.967:0): avc:  denied  { search } for  pid=30341 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:44 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:44 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:44 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:44 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:44 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:44 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:44 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:44 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:44 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:44 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:44 lyta kernel: audit(1105929944.072:0): avc:  denied  { search } for  pid=30341 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: audit(1105929944.150:0): avc:  denied  { search } for  pid=30345 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:44 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:44 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:44 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:44 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:44 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:44 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:44 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:44 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:44 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:44 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75

--Boundary-00=_2HzFC8NAih2IRxV--
