Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUHDJTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUHDJTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUHDJTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:19:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50072 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262085AbUHDJTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:19:14 -0400
Date: Wed, 4 Aug 2004 11:19:03 +0200 (MEST)
Message-Id: <200408040919.i749J3LO001505@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.27-rc5] drivers/macintosh/nvram.c typo
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

File offset fixes in -rc5 introduced a typo (missing semi-colon)
in drivers/macintosh/nvram.c, causing compile failure.
Trivial fix below.

/Mikael

--- linux-2.4.27-rc5/drivers/macintosh/nvram.c.~1~	2004-08-04 10:09:01.000000000 +0200
+++ linux-2.4.27-rc5/drivers/macintosh/nvram.c	2004-08-04 10:44:01.000000000 +0200
@@ -37,7 +37,7 @@
 static ssize_t read_nvram(struct file *file, char *buf,
 			  size_t count, loff_t *ppos)
 {
-	loff_t n = *ppos
+	loff_t n = *ppos;
 	unsigned int i = n;
 	char *p = buf;
 
