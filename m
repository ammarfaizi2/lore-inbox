Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVCEPbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVCEPbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCEPbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:31:19 -0500
Received: from coderock.org ([193.77.147.115]:30115 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261481AbVCEPbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:31:17 -0500
Subject: [patch 2/3] generic.c - vfree() checking cleanups
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:31:08 +0100
Message-Id: <20050305153109.167581F07A@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



generic.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/agp/generic.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/agp/generic.c~vfree-drivers_char_agp_generic drivers/char/agp/generic.c
--- kj/drivers/char/agp/generic.c~vfree-drivers_char_agp_generic	2005-03-05 16:10:29.000000000 +0100
+++ kj-domen/drivers/char/agp/generic.c	2005-03-05 16:10:29.000000000 +0100
@@ -920,8 +920,7 @@ EXPORT_SYMBOL(agp_generic_alloc_by_type)
 
 void agp_generic_free_by_type(struct agp_memory *curr)
 {
-	if (curr->memory != NULL)
-		vfree(curr->memory);
+	vfree(curr->memory);
 
 	agp_free_key(curr->key);
 	kfree(curr);
_
