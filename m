Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVAJSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVAJSwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVAJSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:50:40 -0500
Received: from coderock.org ([193.77.147.115]:57788 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262336AbVAJSrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:47:23 -0500
Subject: [patch 1/2] backend.c - vfree() checking cleanups
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Mon, 10 Jan 2005 19:47:18 +0100
Message-Id: <20050110184719.234DF1F1ED@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



backend.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/agp/backend.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/char/agp/backend.c~vfree-drivers_char_agp_backend drivers/char/agp/backend.c
--- kj/drivers/char/agp/backend.c~vfree-drivers_char_agp_backend	2005-01-10 18:00:58.000000000 +0100
+++ kj-domen/drivers/char/agp/backend.c	2005-01-10 18:00:58.000000000 +0100
@@ -203,10 +203,9 @@ static void agp_backend_cleanup(struct a
 		bridge->driver->cleanup();
 	if (bridge->driver->free_gatt_table)
 		bridge->driver->free_gatt_table();
-	if (bridge->key_list) {
-		vfree(bridge->key_list);
-		bridge->key_list = NULL;
-	}
+
+	vfree(bridge->key_list);
+	bridge->key_list = NULL;
 
 	if (bridge->driver->agp_destroy_page &&
 	    bridge->driver->needs_scratch_page)
_
