Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUBJRAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUBJQ75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:59:57 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:54032 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266001AbUBJQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:57:25 -0500
Date: Tue, 10 Feb 2004 16:57:37 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 1/10] dm: Export dm_vcalloc()
Message-ID: <20040210165737.GG27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export dm_vcalloc()
--- diff/drivers/md/dm-table.c	2004-01-19 10:22:56.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-02-10 16:11:17.000000000 +0000
@@ -149,7 +149,7 @@
 	return 0;
 }
 
-static void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size)
+void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size)
 {
 	unsigned long size;
 	void *addr;
@@ -858,6 +858,7 @@
 }
 
 
+EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
--- diff/drivers/md/dm.h	2004-01-19 10:22:56.000000000 +0000
+++ source/drivers/md/dm.h	2004-02-10 16:11:17.000000000 +0000
@@ -167,4 +167,6 @@
 int dm_stripe_init(void);
 void dm_stripe_exit(void);
 
+void *dm_vcalloc(unsigned long nmemb, unsigned long elem_size);
+
 #endif
