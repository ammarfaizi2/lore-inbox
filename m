Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUHJSMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUHJSMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHJSJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:09:19 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:29949 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S267527AbUHJSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:06:16 -0400
Message-ID: <41190E89.4070203@us.ibm.com>
Date: Tue, 10 Aug 2004 13:06:01 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] ibmveth bug fixes 1/4
Content-Type: multipart/mixed;
 boundary="------------060300060200010004050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300060200010004050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

This and the following three patches contain bug fixes found in the 
stabilization of SLES9.

This patch adds a call to MODULE_VERSION and changes the MODULE_AUTHOR 
call to me (obviously with Dave Larson's permission).  It also 
increments the version number to keep track of the bug fixes.  Please apply.

Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------060300060200010004050609
Content-Type: text/plain;
 name="ibmveth_authver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_authver.patch"

===== drivers/net/ibmveth.c 1.13 vs edited =====
--- 1.13/drivers/net/ibmveth.c	Wed Jun  9 03:44:35 2004
+++ edited/drivers/net/ibmveth.c	Tue Aug 10 11:53:22 2004
@@ -2,8 +2,8 @@
 /*                                                                        */
 /* IBM eServer i/pSeries Virtual Ethernet Device Driver                   */
 /* Copyright (C) 2003 IBM Corp.                                           */
-/*  Dave Larson (larson1@us.ibm.com)                                      */
-/*  Santiago Leon (santil@us.ibm.com)                                     */
+/*  Originally written by Dave Larson (larson1@us.ibm.com)                */
+/*  Maintained by Santiago Leon (santil@us.ibm.com)                       */
 /*                                                                        */
 /*  This program is free software; you can redistribute it and/or modify  */
 /*  it under the terms of the GNU General Public License as published by  */
@@ -104,11 +104,12 @@
 
 static const char ibmveth_driver_name[] = "ibmveth";
 static const char ibmveth_driver_string[] = "IBM i/pSeries Virtual Ethernet Driver";
-static const char ibmveth_driver_version[] = "1.0";
+#define ibmveth_driver_version "1.02"
 
-MODULE_AUTHOR("Dave Larson <larson1@us.ibm.com>");
+MODULE_AUTHOR("Santiago Leon <santil@us.ibm.com>");
 MODULE_DESCRIPTION("IBM i/pSeries Virtual Ethernet Driver");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(ibmveth_driver_version);
 
 /* simple methods of getting data from the current rxq entry */
 static inline int ibmveth_rxq_pending_buffer(struct ibmveth_adapter *adapter)

--------------060300060200010004050609--
