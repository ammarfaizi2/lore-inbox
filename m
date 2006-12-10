Return-Path: <linux-kernel-owner+w=401wt.eu-S1760794AbWLJOWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760794AbWLJOWM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 09:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760803AbWLJOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 09:22:12 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:1573 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760822AbWLJOWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 09:22:04 -0500
Date: Sun, 10 Dec 2006 15:21:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: export get_current_tty
Message-ID: <20061210142151.GA28442@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[PATCH] tty: export get_current_tty

24ec839c431eb79bb8f6abc00c4e1eb3b8c4d517 causes this:

WARNING: "get_current_tty" [drivers/s390/char/fs3270.ko] undefined!

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 drivers/char/tty_io.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c
+++ linux-2.6/drivers/char/tty_io.c
@@ -3821,6 +3821,7 @@ struct tty_struct *get_current_tty(void)
 	barrier();
 	return tty;
 }
+EXPORT_SYMBOL_GPL(get_current_tty);
 
 /*
  * Initialize the console device. This is called *early*, so
