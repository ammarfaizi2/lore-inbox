Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSJ0P4P>; Sun, 27 Oct 2002 10:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSJ0P4P>; Sun, 27 Oct 2002 10:56:15 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:37602 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262441AbSJ0P4O> convert rfc822-to-8bit; Sun, 27 Oct 2002 10:56:14 -0500
content-class: urn:content-classes:message
Subject: typo in 2.4.19 free_area_init_core()?
Date: Sun, 27 Oct 2002 08:01:23 -0800
Message-ID: <51568623CC066847A1DC7EB0D95B587AD2CD@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: typo in 2.4.19 free_area_init_core()?
Thread-Index: AcJ90hWzCuWr4VhvQMauUl7wXJmKFA==
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <marcelo@conectiva.com.br>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2002 16:01:24.0324 (UTC) FILETIME=[19711240:01C27DD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Is this a typo in function free_area_init_core()?  The information on realsize is more interesting than the size variable.



--- mm/page_alloc.c~	Sun Oct 27 00:46:10 2002
+++ mm/page_alloc.c	Sun Oct 27 00:46:35 2002
@@ -735,7 +735,7 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk("zone(%lu): %lu pages.\n", j, realsize);
 		zone->size = size;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;
