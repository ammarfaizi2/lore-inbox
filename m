Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934177AbWKTOWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934177AbWKTOWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934178AbWKTOWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:22:38 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:6610 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S934177AbWKTOWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:22:37 -0500
Date: Mon, 20 Nov 2006 15:22:36 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 1/4][AIO] - fix aio.h includes
Message-ID: <20061120152236.7b56c71e@frecb000686>
In-Reply-To: <20061120151700.4a4f9407@frecb000686>
References: <20061120151700.4a4f9407@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:29:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:29:38,
	Serialize complete at 20/11/2006 15:29:38
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Fix the double inclusion of linux/uio.h in linux/aio.h



 aio.h |    1 -
 1 file changed, 1 deletion(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.19-rc5-mm2/include/linux/aio.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/aio.h	2006-11-17
11:20:08.000000000 +0100 +++ linux-2.6.19-rc5-mm2/include/linux/aio.h
2006-11-17 11:20:27.000000000 +0100 @@ -7,7 +7,6 @@
 #include <linux/uio.h>
 
 #include <asm/atomic.h>
-#include <linux/uio.h>
 
 #define AIO_MAXSEGS		4
 #define AIO_KIOGRP_NR_ATOMIC	8
