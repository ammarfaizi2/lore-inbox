Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVAFLoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVAFLoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVAFLoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:44:04 -0500
Received: from smtp2.libero.it ([193.70.192.52]:4234 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S262619AbVAFLoB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:44:01 -0500
From: Marco Cipullo <cipullo@libero.it>
To: linux-kernel@vger.kernel.org
Subject: From last __GFP_ZERO changes
Date: Thu, 6 Jan 2005 12:43:58 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501061243.58968.cipullo@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From last __GFP_ZERO changes:

--- a/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
+++ b/drivers/block/pktcdvd.c	2005-01-06 03:27:45 -08:00
@@ -135,12 +135,10 @@
 		goto no_bio;
 
 	for (i = 0; i < PAGES_PER_PACKET; i++) {
-		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		pkt->pages[i] = alloc_page(GFP_KERNEL|| __GFP_ZERO);

Is this OK?

Or should be

 	for (i = 0; i < PAGES_PER_PACKET; i++) {
-		pkt->pages[i] = alloc_page(GFP_KERNEL);
+		pkt->pages[i] = alloc_page(GFP_KERNEL| __GFP_ZERO);


Bye
Marco
