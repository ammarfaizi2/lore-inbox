Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVCEPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVCEPrA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVCEPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:37:35 -0500
Received: from coderock.org ([193.77.147.115]:40867 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262002AbVCEPfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:35:37 -0500
Subject: [patch 05/12] gus_wave.c - vfree() checking cleanups
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:22 +0100
Message-Id: <20050305153522.C55381F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gus_wave.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/gus_wave.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN sound/oss/gus_wave.c~vfree-sound_oss_gus_wave sound/oss/gus_wave.c
--- kj/sound/oss/gus_wave.c~vfree-sound_oss_gus_wave	2005-03-05 16:10:41.000000000 +0100
+++ kj-domen/sound/oss/gus_wave.c	2005-03-05 16:10:41.000000000 +0100
@@ -3126,8 +3126,7 @@ void __exit gus_wave_unload(struct addre
 	if (hw_config->slots[5] != -1)
 		sound_unload_mixerdev(hw_config->slots[5]);
 	
-	if(samples)
-		vfree(samples);
+	vfree(samples);
 	samples=NULL;
 }
 /* called in interrupt context */
_
