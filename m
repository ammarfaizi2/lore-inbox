Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTLFBPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTLFBPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:15:15 -0500
Received: from [198.70.193.2] ([198.70.193.2]:19108 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S262745AbTLFBPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:15:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Date: Fri, 5 Dec 2003 17:15:14 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060ED8F@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Thread-Index: AcO7cbMZjhRF8YHOSHaO2cseGM+QAwAI04oQ
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 06 Dec 2003 01:15:15.0364 (UTC) FILETIME=[67925E40:01C3BB96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 05, 2003 12:53 PM, Andrew Vasquez wrote:
> All,
> 
> A new version of the 8.x series driver for Linux 2.6.x kernels has
> been uploaded to SourceForge: 
> 
> 	http://sourceforge.net/projects/linux-qla2xxx/
>

False start.  I've uploaded 8.00.00b8 to the SF site.  This driver
instructs the mid-layer to perform its initial scan with
scsi_scan_host().  During testing, I disable the scan.  Sorry for
the confusion.

BTW: a simple patch to fix the problem against b7 follows.  
Please dismiss 8.00.00b7 (I've since removed it from the SF site).

Regards,
Andrew Vasquez


diff -Nurd 80000b7/qla_os.c 80000b7-scan/qla_os.c
--- 80000b7/qla_os.c	2003-12-05 10:39:58.000000000 -0800
+++ 80000b7-scan/qla_os.c	2003-12-05 16:40:21.855654968 -0800
@@ -72,7 +72,7 @@
 
 int ql2xsuspendcount = SUSPEND_COUNT;
 
-int ql2xdoinitscan = 0;
+int ql2xdoinitscan = 1;
 
 int qla2x00_retryq_dmp;
 
