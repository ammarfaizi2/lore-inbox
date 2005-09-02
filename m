Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVIBTbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVIBTbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVIBTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:31:52 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:33921 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750989AbVIBTbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:31:52 -0400
Date: Fri, 2 Sep 2005 21:31:30 +0200
Message-Id: <200509021931.j82JVU9U025467@wscnet.wsc.cz>
Subject: [PATCH] sound/pci/ali5451/ali5451.c kcalloc(1 to kzalloc
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes one occurence of kcalloc(1, ... to kzalloc.

Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ali5451.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2245,7 +2245,7 @@ static int __devinit snd_ali_create(snd_
 		return -ENXIO;
 	}
 
-	if ((codec = kcalloc(1, sizeof(*codec), GFP_KERNEL)) == NULL) {
+	if ((codec = kzalloc(sizeof(*codec), GFP_KERNEL)) == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
