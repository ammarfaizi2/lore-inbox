Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272799AbTHKRVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTHKQtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:40 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:65112 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272790AbTHKQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:29 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] logic error in gus_wave driver
Message-Id: <E19mFqr-00068c-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/gus_wave.c linux-2.5/sound/oss/gus_wave.c
--- bk-linus/sound/oss/gus_wave.c	2003-05-26 12:57:43.000000000 +0100
+++ linux-2.5/sound/oss/gus_wave.c	2003-07-13 13:33:57.000000000 +0100
@@ -3034,7 +3034,7 @@ void __init gus_wave_init(struct address
 
 	gus_initialize();
 	
-	if ((gus_mem_size > 0) & !gus_no_wave_dma)
+	if ((gus_mem_size > 0) && !gus_no_wave_dma)
 	{
 		hw_config->slots[4] = -1;
 		if ((gus_devnum = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
