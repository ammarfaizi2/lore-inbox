Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVAJSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVAJSwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVAJSux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:50:53 -0500
Received: from coderock.org ([193.77.147.115]:58556 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262424AbVAJSr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:47:26 -0500
Subject: [patch 2/2] generic.c - vfree() checking cleanups
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:47:21 +0100
Message-Id: <20050110184722.68B461F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



generic.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/agp/generic.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/char/agp/generic.c~vfree-drivers_char_agp_generic drivers/char/agp/generic.c
--- kj/drivers/char/agp/generic.c~vfree-drivers_char_agp_generic	2005-01-10 18:00:58.000000000 +0100
+++ kj-domen/drivers/char/agp/generic.c	2005-01-10 18:00:58.000000000 +0100
@@ -920,8 +920,7 @@ EXPORT_SYMBOL(agp_generic_alloc_by_type)
 
 void agp_generic_free_by_type(struct agp_memory *curr)
 {
-	if (curr->memory != NULL)
-		vfree(curr->memory);
+	vfree(curr->memory);
 
 	agp_free_key(curr->key);
 	kfree(curr);
_
