Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTANJiu>; Tue, 14 Jan 2003 04:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTANJiu>; Tue, 14 Jan 2003 04:38:50 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:11462 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261963AbTANJis>; Tue, 14 Jan 2003 04:38:48 -0500
From: "Ivan G." <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.58 Oops when booting from initrd - kobject_del
Date: Tue, 14 Jan 2003 02:47:40 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301140247.40861.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.5.58 (everything but the tag changeset)

My attempt to boot an initrd resulted in the following oops:
(scribbled down important parts)
=======================================================
unable to handle kernel NULL pointer at virtual address 00000064
...
EIP at sysfs_remove_dir + 0xb/0x140
...
Process swapper (pid:1, threadinfo=c3fca000 ...
...
Call Trace:
==========
kobject_del+0x13/0x30
kobject_unregister+0x13/0x30
elv_unregister_queue+0x1c/0x30
unlink_gendisk+0x13/0x40
del_gendisk+0x80/0x140
initrd_release+0x4e/0x90
__fput+0xf1/0x100
filp_close+0x74/0xa0
sys_close+0x62/0xa0
syscall_call+0x7/0xb
prepare_namespace+0x13a/0x1b0
init+0x3a/0x160
init+0x0/0x160
kernel_thread_helper+0x5/0x18
...
Code: 8b 70 28 85 f6 0f 84 1e 01 00 00 8b 06 85 c0 75 08 0f 0b 02
=========================================================

Last I checked initrd worked fine in 2.5.56
============================================================

Another two minor questions for whoever might read this.

- Would it be possible to make Kconfig remember the location from which the
   config file was last loaded? It would be more convenient that way.

- Is Jaroslav Kysela, <perex@suse.cz> the current ALSA maintainer 
	as listed in MAINTAINERS for 2.5.58?




