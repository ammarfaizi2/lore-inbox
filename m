Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266301AbUANF2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUANF2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:28:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:23005 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266301AbUANF2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:28:07 -0500
Message-ID: <002901c3da5f$7d8da910$fd0eb609@srikrishnan>
From: "srikrish" <srikrish@in.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Sparse LUN support
Date: Wed, 14 Jan 2004 11:00:12 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to add these devices to the black list - to handle sparse LUNs properly. 
Srikrishnan

--- linux-2.4.23/drivers/scsi/scsi_scan.c	2004-01-13 11:04:53.000000000 +0530
+++ linux-2.4.23.patched/drivers/scsi/scsi_scan.c	2004-01-13 11:04:36.000000000 +0530
@@ -206,6 +206,9 @@
 	{"SMSC", "USB 2 HS", "*", BLIST_SPARSELUN | BLIST_LARGELUN}, 
 	{"XYRATEX", "RS", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"NEC", "iStorage", "*", BLIST_SPARSELUN | BLIST_LARGELUN | BLIST_FORCELUN},
+        {"IBM", "2105800", "*", BLIST_SPARSELUN},
+        {"IBM", "2105F20", "*", BLIST_SPARSELUN},
+        {"IBM", "2145", "*", BLIST_SPARSELUN},
 
 	/*
 	 * Must be at end of list...

