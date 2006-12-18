Return-Path: <linux-kernel-owner+w=401wt.eu-S1752711AbWLRDql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbWLRDql (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbWLRDqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4285 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752712AbWLRDq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:28 -0500
Date: Mon, 18 Dec 2006 04:46:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/char/mxser_new.c:mxser_hangup() static
Message-ID: <20061218034628.GZ10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global mxser_hangup() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/drivers/char/mxser_new.c.old	2006-12-18 03:07:01.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/char/mxser_new.c	2006-12-18 03:07:12.000000000 +0100
@@ -2066,7 +2066,7 @@
 /*
  * This routine is called by tty_hangup() when a hangup is signaled.
  */
-void mxser_hangup(struct tty_struct *tty)
+static void mxser_hangup(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 

