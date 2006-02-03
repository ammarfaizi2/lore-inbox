Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945979AbWBCVXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945979AbWBCVXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945980AbWBCVXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:23:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945979AbWBCVXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:23:12 -0500
Date: Fri, 3 Feb 2006 16:22:59 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org
Subject: unexport lookup_hash
Message-ID: <20060203212259.GA11066@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, hch@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just stumbled across this whilst checking for planned feature removal,
and missed any discussion why this didn't happen, so I assume Christoph forgot.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/fs/namei.c~	2006-02-03 16:20:49.000000000 -0500
+++ linux-2.6.15.noarch/fs/namei.c	2006-02-03 16:21:07.000000000 -0500
@@ -2668,7 +2668,6 @@ EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
 EXPORT_SYMBOL(getname);
 EXPORT_SYMBOL(lock_rename);
-EXPORT_SYMBOL(lookup_hash);
 EXPORT_SYMBOL(lookup_one_len);
 EXPORT_SYMBOL(page_follow_link_light);
 EXPORT_SYMBOL(page_put_link);
--- linux-2.6.15.noarch/Documentation/feature-removal-schedule.txt~	2006-02-03 16:21:11.000000000 -0500
+++ linux-2.6.15.noarch/Documentation/feature-removal-schedule.txt	2006-02-03 16:21:40.000000000 -0500
@@ -116,13 +116,6 @@ Who:	Harald Welte <laforge@netfilter.org
 
 ---------------------------
 
-What:	EXPORT_SYMBOL(lookup_hash)
-When:	January 2006
-Why:	Too low-level interface.  Use lookup_one_len or lookup_create instead.
-Who:	Christoph Hellwig <hch@lst.de>
-
----------------------------
-
 What:	CONFIG_FORCED_INLINING
 When:	June 2006
 Why:	Config option is there to see if gcc is good enough. (in january
