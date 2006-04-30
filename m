Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWD3OT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWD3OT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 10:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWD3OSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 10:18:22 -0400
Received: from host199-105.pool8255.interbusiness.it ([82.55.105.199]:23192
	"EHLO zion.home.lan") by vger.kernel.org with ESMTP
	id S1751131AbWD3OSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 10:18:00 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/7] uml: fix patch mismerge
Date: Sun, 30 Apr 2006 16:16:09 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060430141609.9060.17002.stgit@zion.home.lan>
In-Reply-To: <20060430141512.9060.39338.stgit@zion.home.lan>
References: <20060430141512.9060.39338.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I sent a patch, it was applied as cda402b283c34a24b091f78eee116963e9494762, then
it was applied again as 181ae4005d0a4010802be534d929b38c42b9ac06 by mistake. But
while the 1st time it modified (correctly) cow_header_v3, the 2nd it modified
cow_header_v3_broken.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow_user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 6ab852b..0ec4052 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -100,7 +100,7 @@ struct cow_header_v3_broken {
 	__u32 alignment;
 	__u32 cow_format;
 	char backing_file[PATH_LEN_V3];
-} __attribute__((packed));
+};
 
 /* COW format definitions - for now, we have only the usual COW bitmap */
 #define COW_BITMAP 0
