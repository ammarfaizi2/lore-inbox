Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbVLOFp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbVLOFp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbVLOFp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:45:57 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:5207 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161130AbVLOFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:45:56 -0500
Message-Id: <20051215054444.854564000.dtor_core@ameritech.net>
References: <20051215053933.125918000.dtor_core@ameritech.net>
Date: Thu, 15 Dec 2005 00:39:36 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: [patch 3/3] wbsd: make use of ARRAY_SIZE() macro
Content-Disposition: inline; filename=wbsd-array-size.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd: make use of ARRAY_SIZE() macro

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/mmc/wbsd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/mmc/wbsd.c
===================================================================
--- work.orig/drivers/mmc/wbsd.c
+++ work/drivers/mmc/wbsd.c
@@ -1399,11 +1399,11 @@ static int __devinit wbsd_scan(struct wb
 	 * Iterate through all ports, all codes to
 	 * find hardware that is in our known list.
 	 */
-	for (i = 0; i < sizeof(config_ports) / sizeof(int); i++) {
+	for (i = 0; i < ARRAY_SIZE(config_ports); i++) {
 		if (!request_region(config_ports[i], 2, DRIVER_NAME))
 			continue;
 
-		for (j = 0; j < sizeof(unlock_codes) / sizeof(int); j++) {
+		for (j = 0; j < ARRAY_SIZE(unlock_codes); j++) {
 			id = 0xFFFF;
 
 			host->config = config_ports[i];
@@ -1419,7 +1419,7 @@ static int __devinit wbsd_scan(struct wb
 
 			wbsd_lock_config(host);
 
-			for (k = 0; k < sizeof(valid_ids) / sizeof(int); k++) {
+			for (k = 0; k < ARRAY_SIZE(valid_ids); k++) {
 				if (id == valid_ids[k]) {
 					host->chip_id = id;
 

