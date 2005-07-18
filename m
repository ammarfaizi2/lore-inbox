Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVGRM3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVGRM3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 08:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGRM3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 08:29:44 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43231 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261175AbVGRM3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 08:29:43 -0400
Date: Mon, 18 Jul 2005 14:30:18 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: [PATCH 2.6.13-rc3-mm1] connector: fix missing dependencies in
 Kconfig
Message-ID: <20050718143018.1bd10031@frecb000711.frec.bull.fr>
Organization: BULL SA.
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/07/2005 14:41:34,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/07/2005 14:41:36,
	Serialize complete at 18/07/2005 14:41:36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

  This patch fixes missing dependencies in drivers/connector/Kconfig
file. We have to ensure that the dependencies of the selected variable
are fulfilled otherwise it can produce some undefined references
during the kernel compilation. This problem was reported by Adrian Bunk.

Signed-off-by: guillaume.thouvenin@bull.net
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Index: linux-2.6.13-rc3-mm1/drivers/connector/Kconfig
===================================================================
--- linux-2.6.13-rc3-mm1.orig/drivers/connector/Kconfig	2005-07-18 13:35:26.000000000 +0200
+++ linux-2.6.13-rc3-mm1/drivers/connector/Kconfig	2005-07-18 13:37:43.000000000 +0200
@@ -12,6 +12,7 @@ config CONNECTOR
 
 config EXIT_CONNECTOR
 	bool "Enable exit connector"
+	depends on NET
 	select CONNECTOR
 	default y
 	---help---
@@ -23,6 +24,7 @@ config EXIT_CONNECTOR
 
 config FORK_CONNECTOR
 	bool "Enable fork connector"
+	depends on NET
 	select CONNECTOR
 	default y
 	---help---
