Return-Path: <linux-kernel-owner+w=401wt.eu-S932226AbXAQJ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbXAQJ67 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbXAQJ6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:58:40 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:42779 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222AbXAQJ6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:58:36 -0500
Date: Wed, 17 Jan 2007 10:48:54 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-aio <linux-aio@kvack.org>,
       Bharata B Rao <bharata@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [PATCH -mm 2/5][AIO] - fix aio.h includes
Message-ID: <20070117104854.01962669@frecb000686>
In-Reply-To: <20070117104601.36b2ab18@frecb000686>
References: <20070117104601.36b2ab18@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 11:06:51,
	Serialize complete at 17/01/2007 11:06:51
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Fix the double inclusion of linux/uio.h in linux/aio.h



 aio.h |    1 -
 1 file changed, 1 deletion(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.20-rc4-mm1/include/linux/aio.h
===================================================================
--- linux-2.6.20-rc4-mm1.orig/include/linux/aio.h	2007-01-12 11:40:39.000000000 +0100
+++ linux-2.6.20-rc4-mm1/include/linux/aio.h	2007-01-12 12:15:01.000000000 +0100
@@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
