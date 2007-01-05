Return-Path: <linux-kernel-owner+w=401wt.eu-S1422667AbXAESsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbXAESsu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbXAESsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:48:13 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34879 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671AbXAESrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:43 -0500
Message-Id: <200701051842.l05IgDPV004617@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/9] UML - Locking commentary in the random driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment the lack of locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/random.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/drivers/random.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/random.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/random.c	2007-01-01 13:12:54.000000000 -0500
@@ -78,6 +78,7 @@ static const struct file_operations rng_
 	.read		= rng_dev_read,
 };
 
+/* rng_init shouldn't be called more than once at boot time */
 static struct miscdevice rng_miscdev = {
 	RNG_MISCDEV_MINOR,
 	RNG_MODULE_NAME,

