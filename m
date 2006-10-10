Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWJJVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWJJVpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWJJVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:45:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30916 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030497AbWJJVor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:47 -0400
To: torvalds@osdl.org
Subject: [PATCH] __iomem annotations in sunzilog
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPP5-0007Jv-4R@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/serial/sunzilog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
index b11f6de..73dd2ee 100644
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1057,7 +1057,7 @@ #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10
 
 static void sunzilog_putchar(struct uart_port *port, int ch)
 {
-	struct zilog_channel *channel = ZILOG_CHANNEL_FROM_PORT(port);
+	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
 
 	/* This is a timed polling loop so do not switch the explicit
-- 
1.4.2.GIT


