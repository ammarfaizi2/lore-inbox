Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTIKVxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbTIKVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:53:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3795 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261567AbTIKVvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:51:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Sep 2003 23:51:38 +0200 (MEST)
Message-Id: <UTC200309112151.h8BLpcb14069.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [PATCH][IDE] update qd65xx driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That reminds me, did I ever send you this?

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
--- a/drivers/ide/legacy/qd65xx.c	Mon Sep  8 23:44:59 2003
+++ b/drivers/ide/legacy/qd65xx.c	Thu Sep 11 23:20:26 2003
@@ -261,7 +261,7 @@
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
+		pio = ide_get_best_pio_mode(drive, 255, pio, &d);
 		pio = IDE_MIN(pio,4);
 
 		switch (pio) {
