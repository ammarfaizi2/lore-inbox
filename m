Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVAJCyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVAJCyG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVAJCyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:54:06 -0500
Received: from news.suse.de ([195.135.220.2]:50882 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262054AbVAJCxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:53:55 -0500
Date: Mon, 10 Jan 2005 03:53:53 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] Fix gcc 4 compilation in DRM
Message-ID: <20050110025353.GC5672@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix gcc 4 compilation in DRM.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/char/drm/drmP.h
===================================================================
--- linux.orig/drivers/char/drm/drmP.h	2005-01-04 18:48:41.%N +0100
+++ linux/drivers/char/drm/drmP.h	2005-01-09 18:11:45.%N +0100
@@ -962,7 +962,6 @@
 extern drm_minor_t    *drm_minors;
 extern struct class_simple *drm_class;
 extern struct proc_dir_entry *drm_proc_root;
-extern struct file_operations drm_stub_fops;
 
 				/* Proc support (drm_proc.h) */
 extern int            drm_proc_init(drm_device_t *dev,
