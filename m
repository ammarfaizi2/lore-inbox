Return-Path: <linux-kernel-owner+w=401wt.eu-S932090AbXACUbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbXACUbY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbXACUbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:31:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59215 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbXACUbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:31:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 3 Jan 2007 21:31:04 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] the scheduled IEEE1394_OUI_DB removal
To: Adrian Bunk <bunk@stusta.de>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20070102215653.GA20714@stusta.de>
Message-ID: <tkrat.7c6a81ad8d62429e@s5r6.in-berlin.de>
References: <20070102215653.GA20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Jan, Adrian Bunk wrote:
> This patch contains the scheduled IEEE1394_OUI_DB removal.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |    8 
>  drivers/ieee1394/Kconfig                   |   14 
>  drivers/ieee1394/Makefile                  |   10 
>  drivers/ieee1394/nodemgr.c                 |   39 
>  drivers/ieee1394/oui.db                    | 7048 ---------------------
>  drivers/ieee1394/oui2c.sh                  |   22 
>  6 files changed, 7141 deletions(-)
...

Committed to linux1394-2.6.git with the following additional hunks:


Index: linux/drivers/ieee1394/.gitignore
===================================================================
--- linux.orig/drivers/ieee1394/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-oui.c
Index: linux/drivers/ieee1394/nodemgr.h
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.h
+++ linux/drivers/ieee1394/nodemgr.h
@@ -70,7 +70,6 @@ struct unit_directory {
 
 	quadlet_t vendor_id;
 	struct csr1212_keyval *vendor_name_kv;
-	const char *vendor_oui;
 
 	quadlet_t model_id;
 	struct csr1212_keyval *model_name_kv;
@@ -93,7 +92,6 @@ struct unit_directory {
 struct node_entry {
 	u64 guid;			/* GUID of this node */
 	u32 guid_vendor_id;		/* Top 24bits of guid */
-	const char *guid_vendor_oui;	/* OUI name of guid vendor id */
 
 	struct hpsb_host *host;		/* Host this node is attached to */
 	nodeid_t nodeid;		/* NodeID */
@@ -104,7 +102,6 @@ struct node_entry {
 	/* The following is read from the config rom */
 	u32 vendor_id;
 	struct csr1212_keyval *vendor_name_kv;
-	const char *vendor_oui;
 
 	u32 capabilities;
 

Resulting diffstat according to git:

 Documentation/feature-removal-schedule.txt |    8
 drivers/ieee1394/.gitignore                |    1
 drivers/ieee1394/Kconfig                   |   14
 drivers/ieee1394/Makefile                  |   10
 drivers/ieee1394/nodemgr.c                 |   39
 drivers/ieee1394/nodemgr.h                 |    3
 drivers/ieee1394/oui.db                    | 7048 ----------------------------
 drivers/ieee1394/oui2c.sh                  |   22
 8 files changed, 0 insertions(+), 7145 deletions(-)
 delete mode 100644 drivers/ieee1394/.gitignore
 delete mode 100644 drivers/ieee1394/oui.db
 delete mode 100644 drivers/ieee1394/oui2c.sh
-- 
Stefan Richter
-=====-=-=== ---= ---==
http://arcgraph.de/sr/

