Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVKIAxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVKIAxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKIAxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:53:23 -0500
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:33511 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932391AbVKIAxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:53:22 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Replace kmalloc/memset with kzalloc.
Message-Id: <20051109005237.48F8520A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 01:52:37 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace kmalloc/memset by kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 kernel/kexec.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

applies-to: 7085a0d56a035f94f292df54c7fe19d822904cec
bc3653f82726b556fbb5c7958f82c5b1e99c2860
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2c95848..94df70f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -104,11 +104,10 @@ static int do_kimage_alloc(struct kimage
 
 	/* Allocate a controlling structure */
 	result = -ENOMEM;
-	image = kmalloc(sizeof(*image), GFP_KERNEL);
+	image = kzalloc(sizeof(*image), GFP_KERNEL);
 	if (!image)
 		goto out;
 
-	memset(image, 0, sizeof(*image));
 	image->head = 0;
 	image->entry = &image->head;
 	image->last_entry = &image->head;
---
0.99.9.GIT
