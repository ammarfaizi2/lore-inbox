Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVEBBry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVEBBry (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVEBBqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:46:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20496 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261619AbVEBBqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:10 -0400
Date: Mon, 2 May 2005 03:46:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] __deprecated_for_modules panic_timeout
Message-ID: <20050502014608.GI3592@stusta.de>
References: <20050415151048.GL5456@stusta.de> <20050423165609.47087f9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423165609.47087f9a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 04:56:09PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I didn't find any possible modular usage in the kernel.
> > 
> 
> panic_timeout has many in-kernel users and it is used from within a module
> in 2.4.30.
> 
> Hence it is easily possible that some out-of-tree code is dependent upon
> this export, hence I shan't be applying this patch.

Patch to deprecate it is below.

cu
Adrian


<--  snip  -->


--- linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt.old	2005-05-02 00:03:06.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/Documentation/feature-removal-schedule.txt	2005-05-02 00:03:52.000000000 +0200
@@ -65,0 +66,8 @@
+
+---------------------------
+
+What:	remove EXPORT_SYMBOL(panic_timeout)
+When:	April 2006
+Files:	kernel/panic.c
+Why:	No modular usage in the kernel.
+Who:	Adrian Bunk <bunk@stusta.de>
--- linux-2.6.12-rc3-mm2-full/include/linux/kernel.h.old	2005-05-02 00:04:02.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/include/linux/kernel.h	2005-05-02 00:04:22.000000000 +0200
@@ -163 +163 @@
-extern int panic_timeout;
+extern __deprecated_for_modules int panic_timeout;

