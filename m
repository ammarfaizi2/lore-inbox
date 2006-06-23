Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933020AbWFWK7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbWFWK7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbWFWKz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:55:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933017AbWFWKzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:52 -0400
Date: Fri, 23 Jun 2006 12:55:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make kernel/utsname.c:clone_uts_ns()
Message-ID: <20060623105551.GR9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global clone_uts_ns() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/kernel/utsname.c.old	2006-06-22 20:53:20.000000000 +0200
+++ linux-2.6.17-mm1-full/kernel/utsname.c	2006-06-22 20:53:31.000000000 +0200
@@ -19,7 +19,7 @@
  * @old_ns: namespace to clone
  * Return NULL on error (failure to kmalloc), new ns otherwise
  */
-struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
+static struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
 {
 	struct uts_namespace *ns;
 

