Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278803AbRJ3XyF>; Tue, 30 Oct 2001 18:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRJ3Xxy>; Tue, 30 Oct 2001 18:53:54 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:9200 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S278803AbRJ3Xxj>;
	Tue, 30 Oct 2001 18:53:39 -0500
Date: Wed, 31 Oct 2001 04:53:54 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] init/main.c/root_dev_names - another one #ifdef
Message-ID: <20011031045353.A22507@zzz.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to include the SCSI disk's names into the list only if we
compile the kernel with the corresponding support.  It's not very
serious patch, but to put the things in order...  Linus, please, apply
it.

--- init/main.c.orig	Wed Oct 31 02:23:48 2001
+++ init/main.c	Wed Oct 31 02:44:02 2001
@@ -166,6 +166,7 @@
 	{ "hdr",     0x5A40 },
 	{ "hds",     0x5B00 },
 	{ "hdt",     0x5B40 },
+#ifdef CONFIG_BLK_DEV_SD
 	{ "sda",     0x0800 },
 	{ "sdb",     0x0810 },
 	{ "sdc",     0x0820 },
@@ -182,6 +183,7 @@
 	{ "sdn",     0x08d0 },
 	{ "sdo",     0x08e0 },
 	{ "sdp",     0x08f0 },
+#endif
 	{ "ada",     0x1c00 },
 	{ "adb",     0x1c10 },
 	{ "adc",     0x1c20 },
