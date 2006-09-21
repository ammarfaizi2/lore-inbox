Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWIUSxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWIUSxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWIUSxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:53:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:24885 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750779AbWIUSxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:53:40 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,196,1157353200"; 
   d="scan'208"; a="132128897:sNHT19678953"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] clean up unused kiocb variables
Date: Thu, 21 Sep 2006 11:53:40 -0700
Message-ID: <000001c6ddaf$40d4eff0$ff0da8c0@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acbdr0CcW/s8h5pfRvqiRRFXga0SVw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason why we keep these two variables around for kiocb structure?
They are not used anywhere.

Patch to tidy up kiocb structure.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./include/linux/aio.h.orig	2006-09-21 10:03:36.000000000 -0700
+++ ./include/linux/aio.h	2006-09-21 10:03:56.000000000 -0700
@@ -110,8 +110,6 @@
 	char 			__user *ki_buf;	/* remaining iocb->aio_buf */
 	size_t			ki_left; 	/* remaining bytes */
 	long			ki_retried; 	/* just for testing */
-	long			ki_kicked; 	/* just for testing */
-	long			ki_queued; 	/* just for testing */
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
