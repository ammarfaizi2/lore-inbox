Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274884AbTHPQp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274885AbTHPQp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:45:28 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:23848
	"EHLO gaston") by vger.kernel.org with ESMTP id S274884AbTHPQp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:45:27 -0400
Subject: [PATCH] Fix ide-scsi build with driver model change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061052286.598.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 18:44:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

This fixes build of ide-scsi after removal of struct device.name

Please apply,
Ben.

===== drivers/scsi/ide-scsi.c 1.29 vs edited =====
--- 1.29/drivers/scsi/ide-scsi.c	Sat Aug 16 13:57:02 2003
+++ edited/drivers/scsi/ide-scsi.c	Sat Aug 16 14:39:37 2003
@@ -948,7 +948,6 @@
 };
 
 static struct device     idescsi_primary = {
-	.name		= "Ide-scsi Parent",
 	.bus_id		= "ide-scsi",
 };
 static struct bus_type   idescsi_emu_bus = {

