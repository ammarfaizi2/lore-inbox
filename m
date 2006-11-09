Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424091AbWKIP7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424091AbWKIP7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424092AbWKIP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:59:00 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:56995 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1424091AbWKIP67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:58:59 -0500
Subject: [PATCH -mm 1/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       "moi @ Bull" <sebastien.dugue@bull.net>
In-Reply-To: <1163087717.3879.34.camel@frecb000686>
References: <1163087717.3879.34.camel@frecb000686>
Date: Thu, 09 Nov 2006 16:58:45 +0100
Message-Id: <1163087925.3879.38.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:05:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:05:43,
	Serialize complete at 09/11/2006 17:05:43
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Fix the double inclusion of linux/uio.h in linux/aio.h



 aio.h |    1 -
 1 file changed, 1 deletion(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.19-rc5-mm1/include/linux/aio.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/aio.h	2006-11-09 10:43:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/linux/aio.h	2006-11-09 10:46:18.000000000 +0100
@@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8


