Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVIOUi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVIOUi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbVIOUi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:38:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55243 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932081AbVIOUi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:38:27 -0400
Subject: inotify bug?
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@novell.com>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 16:12:51 -0400
Message-Id: <1126815172.3185.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this in dmesg with 2.6.13-rc7-rt3 the other day.  Maybe it's
useful.  There were no visible effects.

idr_remove called for id=1024 which is not allocated.
 [sub_remove+157/272] sub_remove+0x9d/0x110 (8)
 [__wake_up+44/80] __wake_up+0x2c/0x50 (28) 
 [idr_remove+24/128] idr_remove+0x18/0x80 (28)
 [remove_watch_no_event+77/208] remove_watch_no_event+0x4d/0xd0 (12)
 [inotify_inode_is_dead+88/128] inotify_inode_is_dead+0x58/0x80 (12)
 [prune_dcache+222/480] prune_dcache+0xde/0x1e0 (28)
 [shrink_dcache_memory+56/64] shrink_dcache_memory+0x38/0x40 (28)
 [shrink_slab+277/416] shrink_slab+0x115/0x1a0 (4)
 [balance_pgdat+686/1024] balance_pgdat+0x2ae/0x400 (48)
 [kswapd+168/240] kswapd+0xa8/0xf0 (96)
 [autoremove_wake_function+0/48] autoremove_wake_function+0x0/0x30 (12)
 [kswapd+0/240] kswapd+0x0/0xf0 (16)
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18 (16)

Lee

