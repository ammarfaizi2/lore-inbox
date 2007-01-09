Return-Path: <linux-kernel-owner+w=401wt.eu-S1750940AbXAICM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXAICM0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXAICL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:11:58 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44481 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbXAICLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:54 -0500
Message-Id: <200701090205.l0925kEv024376@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/7] UML - Initialize a list head
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to initialize lists properly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/stdio_console.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2007-01-08 14:34:34.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2007-01-08 17:12:30.000000000 -0500
@@ -69,6 +69,7 @@ static struct line_driver driver = {
 	.symlink_from 		= "ttys",
 	.symlink_to 		= "vc",
 	.mc  = {
+		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "con",
 		.config 	= con_config,
 		.get_config 	= con_get_config,

