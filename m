Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTIVPzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbTIVPyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:54:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41106 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263209AbTIVPxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:53:10 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: torvalds@osdl.org, akpm@zip.com.au, thornber@sistina.com
Subject: [PATCH] DM 5/6: Message fix in dm-linear
Date: Mon, 22 Sep 2003 10:52:57 -0500
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200309221044.21694.kevcorry@us.ibm.com>
In-Reply-To: <200309221044.21694.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221052.57006.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error message when linear targets gets handed more than 2 arguments.
[Alasdair Kergon]

--- diff/drivers/md/dm-linear.c	2003-09-17 13:08:44.000000000 +0100
+++ source/drivers/md/dm-linear.c	2003-09-17 13:09:34.000000000 +0100
@@ -28,7 +28,7 @@
 	struct linear_c *lc;
 
 	if (argc != 2) {
-		ti->error = "dm-linear: Not enough arguments";
+		ti->error = "dm-linear: Invalid argument count";
 		return -EINVAL;
 	}
 

