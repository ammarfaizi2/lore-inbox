Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318948AbSHMF7p>; Tue, 13 Aug 2002 01:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318950AbSHMF7p>; Tue, 13 Aug 2002 01:59:45 -0400
Received: from ool-4353be98.dyn.optonline.net ([67.83.190.152]:33132 "HELO
	dps7.oconnoronline.net") by vger.kernel.org with SMTP
	id <S318948AbSHMF7p>; Tue, 13 Aug 2002 01:59:45 -0400
Subject: [PATCH] devfs broken in pre2
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Aug 2002 03:11:34 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020813071135.A147619@dps7.oconnoronline.net>
From: billy@oconnoronline.net (Billy O'Connor)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This brings back the number member of the hd_struct structure until 
the devfs_register_disc and devfs_register_partitions functions can 
be made to work without it.  Thanks to John Kim for pointing out 
the location.

--- linux-2.4.19/include/linux/genhd.h	2002-08-12 16:51:43.000000000 -0400
+++ linux-2.4.19-new/include/linux/genhd.h	2002-08-12 16:52:32.000000000 -0400
@@ -62,6 +62,7 @@
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
+	int number;
 
 #ifdef CONFIG_BLK_STATS
 	/* Performance stats: */

--
Billy O'Connor
