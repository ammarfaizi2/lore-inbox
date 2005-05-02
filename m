Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVEBBqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVEBBqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVEBBqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:46:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19984 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261617AbVEBBqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:00 -0400
Date: Mon, 2 May 2005 03:45:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] __deprecated_for_modules insert_resource
Message-ID: <20050502014558.GH3592@stusta.de>
References: <20050415151043.GJ5456@stusta.de> <20050423164411.51d77bf1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423164411.51d77bf1.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 04:44:11PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I didn't find any possible modular usage in the kernel.
> > 
> 
> True, but this looks like something which out-of-tree code could possibly
> be using.  I'd prefer to see this one get the deprecated_for_modules
> twelve-month treatment.
>...

Patch below.

cu
Adrian


<--  snip  -->


--- linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt.old	2005-05-01 23:59:05.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt	2005-05-02 00:00:17.000000000 +0200
@@ -57,0 +58,8 @@
+
+---------------------------
+
+What:	remove EXPORT_SYMBOL(insert_resource)
+When:	April 2006
+Files:	kernel/resource.c
+Why:	No modular usage in the kernel.
+Who:	Adrian Bunk <bunk@stusta.de>
--- linux-2.6.12-rc3-mm2-full/include/linux/ioport.h.old	2005-05-02 00:00:30.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/ioport.h	2005-05-02 00:00:56.000000000 +0200
@@ -97 +97 @@
-extern int insert_resource(struct resource *parent, struct resource *new);
+extern __deprecated_for_modules int insert_resource(struct resource *parent, struct resource *new);

