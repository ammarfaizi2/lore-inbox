Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSLIR0T>; Mon, 9 Dec 2002 12:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSLIR0T>; Mon, 9 Dec 2002 12:26:19 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:18869 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265851AbSLIR0S>; Mon, 9 Dec 2002 12:26:18 -0500
Date: Mon, 9 Dec 2002 12:33:56 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: s390 2.4.20 compilation fix
Message-ID: <20021209123356.A22259@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pretty sure you must have it in your tree somewhere, so
just to show that we've been paying attention, here it is.

diff -ur -X dontdiff linux-2.4.20/drivers/s390/s390io.c linux-2.4.20-s390/drivers/s390/s390io.c
--- linux-2.4.20/drivers/s390/s390io.c	2002-12-06 18:07:11.000000000 -0800
+++ linux-2.4.20-s390/drivers/s390/s390io.c	2002-12-06 18:10:01.000000000 -0800
@@ -8607,8 +8607,8 @@
 cio_ignore_proc_write (struct file *file, const char *user_buf,
 		       size_t user_len, loff_t * offset)
 {
-	char *buffer
-	
+	char *buffer;
+
 	if(user_len > 65536)
 		user_len = 65536;
 	
