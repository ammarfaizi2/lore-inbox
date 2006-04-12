Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDLI2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDLI2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 04:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWDLI2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 04:28:07 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:29355 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932065AbWDLI2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 04:28:06 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060412082905.25857.66985.sendpatchset@cherry.local>
Subject: [PATCH] Kexec: Remove duplicate rimage
Date: Wed, 12 Apr 2006 17:28:06 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec: Remove duplicate rimage

*rimage is already set to image before returning in kimage_normal_alloc().

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

Applies on top of linux-2.6.17-rc1-git5

 kexec.c |    2 --
 1 files changed, 2 deletions(-)

--- 0001/kernel/kexec.c
+++ work/kernel/kexec.c	2006-04-12 15:48:54.000000000 +0900
@@ -218,8 +218,6 @@ static int kimage_normal_alloc(struct ki
 	if (result)
 		goto out;
 
-	*rimage = image;
-
 	/*
 	 * Find a location for the control code buffer, and add it
 	 * the vector of segments so that it's pages will also be
