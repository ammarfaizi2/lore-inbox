Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUIGOmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUIGOmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUIGOjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:39:13 -0400
Received: from verein.lst.de ([213.95.11.210]:36249 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268132AbUIGOhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:37:48 -0400
Date: Tue, 7 Sep 2004 16:37:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mark install_page static
Message-ID: <20040907143741.GA8606@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not used anywhere in modules and it really shouldn't either.


--- 1.28/mm/fremap.c	2004-08-23 10:15:12 +02:00
+++ edited/mm/fremap.c	2004-09-07 13:51:20 +02:00
@@ -99,8 +99,6 @@
 	spin_unlock(&mm->page_table_lock);
 	return err;
 }
-EXPORT_SYMBOL(install_page);
-
 
 /*
  * Install a file pte to a given virtual memory address, release any
