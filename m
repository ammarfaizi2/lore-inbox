Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVCFXtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVCFXtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVCFXrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:10 -0500
Received: from coderock.org ([193.77.147.115]:2736 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261578AbVCFWhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:15 -0500
Subject: [patch 14/14] drivers/message/fusion/*: convert to pci_register_driver
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, c.lucas@ifrance.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:37:00 +0100
Message-Id: <20050306223700.7E9DF1EDA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


convert from pci_module_init to pci_register_driver

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/message/fusion/mptbase.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/message/fusion/mptbase.c~pci_register_driver-drivers_message_fusion drivers/message/fusion/mptbase.c
--- kj/drivers/message/fusion/mptbase.c~pci_register_driver-drivers_message_fusion	2005-03-05 16:12:30.000000000 +0100
+++ kj-domen/drivers/message/fusion/mptbase.c	2005-03-05 16:12:30.000000000 +0100
@@ -5913,7 +5913,7 @@ fusion_init(void)
 #ifdef CONFIG_PROC_FS
 	(void) procmpt_create();
 #endif
-	r = pci_module_init(&mptbase_driver);
+	r = pci_register_driver(&mptbase_driver);
 	if(r)
 		return(r);
 
_
