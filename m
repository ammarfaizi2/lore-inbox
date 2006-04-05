Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWDEBwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWDEBwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWDEBwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:52:07 -0400
Received: from xenotime.net ([66.160.160.81]:14212 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751068AbWDEBwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:52:06 -0400
Date: Tue, 4 Apr 2006 18:54:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mpm@selenic.com, akpm <akpm@osdl.org>
Subject: [PATCH] netconsole: set .name in struct console
Message-Id: <20060404185420.fbf128c8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Set .name in netconsole's struct console to identify the
struct's owner.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/net/netconsole.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2617-rc1.orig/drivers/net/netconsole.c
+++ linux-2617-rc1/drivers/net/netconsole.c
@@ -87,6 +87,7 @@ static void write_msg(struct console *co
 }
 
 static struct console netconsole = {
+	.name = "netcon",
 	.flags = CON_ENABLED | CON_PRINTBUFFER,
 	.write = write_msg
 };


---
