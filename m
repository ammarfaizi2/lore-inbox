Return-Path: <linux-kernel-owner+w=401wt.eu-S932233AbXADBYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbXADBYT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 20:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbXADBYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 20:24:19 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:38281 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932233AbXADBYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 20:24:18 -0500
X-Greylist: delayed 4187 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 20:24:18 EST
Date: Thu, 4 Jan 2007 02:14:21 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
Message-ID: <20070104001420.GA32440@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just a simple test I did...
xfs_freeze -f /mnt/newtest
cp /etc/fstab /mnt/newtest
xfs_freeze -u /mnt/newtest

2007-01-04 01:44:30.341979500 <4>BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock()
2007-01-04 01:44:30.385771500 <4> [<c0103cfb>] dump_trace+0x215/0x21a
2007-01-04 01:44:30.385774500 <4> [<c0103da3>] show_trace_log_lvl+0x1a/0x30
2007-01-04 01:44:30.385775500 <4> [<c0103dcb>] show_trace+0x12/0x14
2007-01-04 01:44:30.385777500 <4> [<c0103ec8>] dump_stack+0x19/0x1b
2007-01-04 01:44:30.385778500 <4> [<c013a3af>] debug_mutex_unlock+0x69/0x120
2007-01-04 01:44:30.385779500 <4> [<c04b4aac>] __mutex_unlock_slowpath+0x44/0xf0
2007-01-04 01:44:30.385780500 <4> [<c04b4887>] mutex_unlock+0x8/0xa
2007-01-04 01:44:30.385782500 <4> [<c018d0ba>] thaw_bdev+0x57/0x6e
2007-01-04 01:44:30.385791500 <4> [<c026a6cf>] xfs_ioctl+0x7ce/0x7d3
2007-01-04 01:44:30.385793500 <4> [<c0269158>] xfs_file_ioctl+0x33/0x54
2007-01-04 01:44:30.385794500 <4> [<c01793f2>] do_ioctl+0x76/0x85
2007-01-04 01:44:30.385795500 <4> [<c0179570>] vfs_ioctl+0x59/0x1aa
2007-01-04 01:44:30.385796500 <4> [<c0179728>] sys_ioctl+0x67/0x77
2007-01-04 01:44:30.385797500 <4> [<c0102e73>] syscall_call+0x7/0xb
2007-01-04 01:44:30.385799500 <4> [<001be410>] 0x1be410
2007-01-04 01:44:30.385800500 <4> =======================

fstab was there just fine after -u.

Linux 2.6.19.1 SMP on Pentium D.

-- 
