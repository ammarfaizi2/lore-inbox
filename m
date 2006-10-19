Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946458AbWJSU0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946458AbWJSU0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946455AbWJSU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:26:47 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:28316 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946457AbWJSU0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:46 -0400
Message-id: <233127106965420505@wsc.cz>
Subject: [PATCH 2/7] Char: isicom, rename init function
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, rename init function

Rename init function from setup to init and mark it as __init, not __devinit.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e6fff2d2ab2153655ef957b6dc1e02baa9921b47
tree e67bb988a24ba312e43126f9bf74d85055945ca2
parent 71d53f8a4e470e305f9cb9ea5a25ebda21c0cd31
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:19:55 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:19:55 +0200

 drivers/char/isicom.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index c9563c2..66fb11f 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1860,7 +1860,7 @@ static void __devexit isicom_remove(stru
 	release_region(board->base, 16);
 }
 
-static int __devinit isicom_setup(void)
+static int __init isicom_init(void)
 {
 	int retval, idx, channel;
 	struct isi_port *port;
@@ -1964,7 +1964,7 @@ static void __exit isicom_exit(void)
 	put_tty_driver(isicom_normal);
 }
 
-module_init(isicom_setup);
+module_init(isicom_init);
 module_exit(isicom_exit);
 
 MODULE_AUTHOR("MultiTech");
