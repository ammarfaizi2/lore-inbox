Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTFLQzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTFLQzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:55:14 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:55460 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S264899AbTFLQzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:55:07 -0400
Date: Thu, 12 Jun 2003 19:07:56 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: lord@sgi.com
Subject: [2.5.70][XFS] Sleeping function called from illegal context
Message-ID: <20030612170756.GA1357@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I get this at shutdown, just after umount:

Debug: Sleeping function called from illegal context at
kernel/workqueue.c:327
Call Trace:
__might_sleep+0x5f/0x90
flush_workqueue+0x1f/0x360
xfs_idestroy+0x6e/0xb0
xfs_sync_inodes+01da/0xa80
xfs_sync_inodes+01da/0xa80
apic_timer_interrupt+0x1a/0x20
pagebuf_delwri_flush+0x9b/0x480
xfs_flush_buftarg+0x21/0x30
xfs_unmount+0xd1/0x180
wakeupup_process+0x26/0x30
linvfs_sosp+0x0/0x60
vfs_unmount+0x34/0x40
linvfs_put_super+0x1d/0x50
generic_shutdown_super+0x3b4/0x420
kill_block_super+0x1d/0x50
deactivate_super+0xd2/0x2b0
free_vfsmnt+0x20/0x30
xfs_fs_type+0x0/0xa0
sys_umount+0x3c/x0a0
sys_oldumount+0x19/0x20
syscall_call+0x7/0xb


I see it  almost every time I shutdown my  PC. Kernel is 2.5.70 vanilla,
UP with CONFIG_PREEMPT. XFS is compiled as module.


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Alcuni pensano che io sia una persona orribile, ma non vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.
