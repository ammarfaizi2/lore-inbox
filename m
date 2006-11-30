Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWK3Pu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWK3Pu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030620AbWK3Pu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 10:50:57 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:6566 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030608AbWK3Puz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 10:50:55 -0500
Date: Thu, 30 Nov 2006 16:49:54 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio <linux-aio@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Bharata B Rao <bharata@in.ibm.com>
Subject: Re: [PATCH -mm 2/5][AIO] - fix aio.h includes
Message-ID: <20061130164954.37500598@frecb000686>
In-Reply-To: <20061130163839.38689215@frecb000686>
References: <20061130163839.38689215@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:05,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/11/2006 16:58:09,
	Serialize complete at 30/11/2006 16:58:09
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Fix the double inclusion of linux/uio.h in linux/aio.h



 aio.h |    1 -
 1 file changed, 1 deletion(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.19-rc6-mm2/include/linux/aio.h
===================================================================
--- linux-2.6.19-rc6-mm2.orig/include/linux/aio.h	2006-11-30 10:54:20.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/linux/aio.h	2006-11-30 13:18:15.000000000 +0100
@@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
