Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTAZBCL>; Sat, 25 Jan 2003 20:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbTAZBCK>; Sat, 25 Jan 2003 20:02:10 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:48512 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266453AbTAZBCJ>;
	Sat, 25 Jan 2003 20:02:09 -0500
Date: Sat, 25 Jan 2003 20:15:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pnp id size fix (1/6)
Message-ID: <20030125201514.GA2246@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets the id size to 8, not 7.

-Adam

--- a/include/linux/pnp.h	Tue Jan 14 05:59:30 2003
+++ b/include/linux/pnp.h	Fri Jan 17 14:02:33 2003
@@ -23,6 +23,7 @@
 #define DEVICE_COUNT_IO		8
 #define DEVICE_COUNT_MEM	4
 #define MAX_DEVICES		8
+#define PNP_ID_LEN		8
 
 struct pnp_resource;
 struct pnp_protocol;
@@ -148,7 +149,7 @@
 }
 
 struct pnp_fixup {
-	char id[7];
+	char id[PNP_ID_LEN];
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
@@ -180,20 +181,20 @@
  */
 
 struct pnp_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	struct pnp_id * next;
 };
 
 struct pnp_device_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 };
 
 struct pnp_card_device_id {
-	char id[7];
+	char id[PNP_ID_LEN];
 	unsigned long driver_data;	/* data private to the driver */
 	struct {
-		char id[7];
+		char id[PNP_ID_LEN];
 	} devs[MAX_DEVICES];		/* logical devices */
 };
 
