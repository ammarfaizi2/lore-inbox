Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUBOUjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUBOUjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 15:39:14 -0500
Received: from mail.alu.ua.es ([193.145.233.9]:32426 "EHLO mail.alu.ua.es")
	by vger.kernel.org with ESMTP id S261735AbUBOUjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 15:39:13 -0500
Subject: [PATCH] cs_types.h
From: Daniel Micol Ponce <dmp18@alu.ua.es>
Reply-To: daniel.micol@unix.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076877551.32074.22.camel@DMICOL.MICOLPONCE>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 21:39:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patch changes ioaddr_t type to u_int because it caused a
comparsion in drivers/pcmcia/i82092.c to be always false.

--- linux-2.6.3-rc3/include/pcmcia/cs_types.h	2004-02-06
13:29:21.000000000 +0100
+++ linux-2.6.3-rc4/include/pcmcia/cs_types.h	2004-02-15
20:41:21.264547152 +0100
@@ -39,7 +39,7 @@
 #ifdef __arm__
 typedef u_int   ioaddr_t;
 #else
-typedef u_short	ioaddr_t;
+typedef u_int	ioaddr_t;
 #endif
 
 typedef u_short	socket_t;


Hope this helps.

	Daniel Micol

