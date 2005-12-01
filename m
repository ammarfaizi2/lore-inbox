Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVLAN1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVLAN1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLAN1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:27:31 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:30914 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S932230AbVLAN1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:27:30 -0500
Subject: [PATCH 4/4] linux-2.6-block: deactivating pagecache for benchmarks
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: Jens Axboe <axboe@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:27:20 +0100
Message-Id: <1133443640.6110.46.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last but not least the Kconfig-file from /linux/block

Signed-Off-By: Dirk Gerdes <mail@dirk-gerdes.de>

--- linux-2.6-block_clean/block/Kconfig	2005-11-30 16:12:30.000000000
+0100
+++ linux-2.6-block-pagecache-clean/block/Kconfig	2005-11-30 17:14:40.000000000 +0100
@@ -12,3 +12,9 @@ config LBD
 	  bigger than 2TB.  Otherwise say N.
 
 source block/Kconfig.iosched
+
+config PAGECACHE_TOGGLE
+	bool "toggle for using pagecache reading from block-devices"
+	help
+	  This is very useful if you would likr to do benchmarks on the 
+	  performance of the I/O-Schedulers.

