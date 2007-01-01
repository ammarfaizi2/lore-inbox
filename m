Return-Path: <linux-kernel-owner+w=401wt.eu-S932810AbXAATxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbXAATxj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbXAATxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:53:08 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52697 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbXAATwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:45 -0500
Message-Id: <200701011947.l01JlFBY020781@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/8] UML - Kill a compilation warning
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill a compilation warning.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/exec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/exec.c	2007-01-01 11:32:22.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/exec.c	2007-01-01 11:45:15.000000000 -0500
@@ -39,9 +39,9 @@ static long execve1(char *file, char __u
 		    char __user *__user *env)
 {
         long error;
+#ifdef CONFIG_TTY_LOG
 	struct tty_struct *tty;
 
-#ifdef CONFIG_TTY_LOG
 	mutex_lock(&tty_mutex);
 	tty = get_current_tty();
 	if (tty)

