Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbUKMNPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUKMNPx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUKMNNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:13:18 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52453 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262730AbUKMNMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:12:41 -0500
Date: Sat, 13 Nov 2004 14:12:33 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411131312.iADDCXA18922@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] add __initdata in floppy.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2004-08-26 22:05:14.000000000 +0200
+++ b/drivers/block/floppy.c	2004-11-13 14:16:40.000000000 +0100
@@ -4124,7 +4124,7 @@ static struct param_table {
 	int *var;
 	int def_param;
 	int param2;
-} config_params[] = {
+} config_params[] __initdata = {
 	{"allowed_drive_mask", NULL, &allowed_drive_mask, 0xff, 0}, /* obsolete */
 	{"all_drives", NULL, &allowed_drive_mask, 0xff, 0},	/* obsolete */
 	{"asus_pci", NULL, &allowed_drive_mask, 0x33, 0},
