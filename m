Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWFYUSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWFYUSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWFYUSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:18:46 -0400
Received: from colin.muc.de ([193.149.48.1]:25874 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932252AbWFYUSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:18:45 -0400
Date: 25 Jun 2006 22:18:44 +0200
Date: Sun, 25 Jun 2006 22:18:44 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org, dhowells@redhat.com,
       trond.myklebust@fys.uio.no
Subject: [PATCH] Fix NFS compilation in -git9
Message-ID: <20060625201844.GA58650@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Needed to fix NFS compilation 

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/fs/nfs/internal.h
===================================================================
--- linux.orig/fs/nfs/internal.h
+++ linux/fs/nfs/internal.h
@@ -1,3 +1,6 @@
+#ifndef INTERNAL_H
+#define INTERNAL_H 1
+
 /*
  * NFS internal definitions
  */
@@ -184,3 +187,5 @@ static inline int valid_ipaddr4(const ch
 	}
 	return 0;
 }
+
+#endif
