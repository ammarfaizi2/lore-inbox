Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030592AbWJCWGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWJCWGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWJCWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:06:34 -0400
Received: from av4.karneval.cz ([81.27.192.11]:10771 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030592AbWJCWGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:06:32 -0400
Message-id: <126432123123@karneval.cz>
Subject: [PATCH 6/6] Char: mxser_new, CMSPAR is defined
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:06:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, CMSPAR is defined

There is no need to have another (ifndeffed) definition of CMSPAR. It's
defined in includes.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 6545715838791f2e9f1501b5b48fae69f2d82d35
tree 1a289cd1a7c4d0e744c5036ebdd92ba4d40cb52f
parent b4f8f18a380e652a92f0dbd41622b5f536a00bed
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 23:59:23 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 23:59:23 +0200

 drivers/char/mxser_new.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index d4cb2d8..cb9c865 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -1602,10 +1602,6 @@ static int mxser_read_register(int port,
 	return id;
 }
 
-#ifndef CMSPAR
-#define	CMSPAR 010000000000
-#endif
-
 static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 {
 	struct mxser_port *port;
