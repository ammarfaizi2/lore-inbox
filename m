Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVCVCJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVCVCJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVCVCG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:06:57 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:18315 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262329AbVCVBfc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:32 -0500
Message-Id: <20050322013500.335148000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:17 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Hagervall <hager@cs.umu.se>
Content-Disposition: inline; filename=dvb-sparse-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 44/48] sparse warnings on one-bit bitfields
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some sparse warnings on one-bit bitfields.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb_ca_en50221.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:28:04.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-03-22 00:28:26.000000000 +0100
@@ -148,13 +148,13 @@ struct dvb_ca_private {
 	wait_queue_head_t thread_queue;
 
 	/* Flag indicating when thread should exit */
-	int exit:1;
+	unsigned int exit:1;
 
 	/* Flag indicating if the CA device is open */
-	int open:1;
+	unsigned int open:1;
 
 	/* Flag indicating the thread should wake up now */
-	int wakeup:1;
+	unsigned int wakeup:1;
 
 	/* Delay the main thread should use */
 	unsigned long delay;

--

