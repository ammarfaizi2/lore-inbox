Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966973AbWK2KfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966973AbWK2KfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966997AbWK2Kel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:34:41 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:50653 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S966973AbWK2KeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:34:17 -0500
Date: Wed, 29 Nov 2006 11:32:23 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH -mm 2/5][AIO] - fix aio.h includes
Message-ID: <20061129113223.743987e6@frecb000686>
In-Reply-To: <20061129112441.745351c9@frecb000686>
References: <20061129112441.745351c9@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:18,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2006 11:41:24,
	Serialize complete at 29/11/2006 11:41:24
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
--- linux-2.6.19-rc6-mm2.orig/include/linux/aio.h	2006-11-16
05:03:40.000000000 +0100 +++ linux-2.6.19-rc6-mm2/include/linux/aio.h
2006-11-28 12:51:41.000000000 +0100 @@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8

