Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVAKXna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVAKXna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVAKXmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:42:37 -0500
Received: from coderock.org ([193.77.147.115]:11974 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262952AbVAKXf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:28 -0500
Subject: [patch 10/11] gus_wave.c - vfree() checking cleanups
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:20 +0100
Message-Id: <20050111233521.1D35A1F226@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gus_wave.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/gus_wave.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN sound/oss/gus_wave.c~vfree-sound_oss_gus_wave sound/oss/gus_wave.c
--- kj/sound/oss/gus_wave.c~vfree-sound_oss_gus_wave	2005-01-10 18:01:07.000000000 +0100
+++ kj-domen/sound/oss/gus_wave.c	2005-01-10 18:01:07.000000000 +0100
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
