Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTIJMs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTIJMs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 08:48:26 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:138 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262861AbTIJMsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 08:48:24 -0400
From: Angus Sawyer <angus.sawyer@dsl.pipex.com>
Reply-To: angus.sawyer@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mwave char/Kconfig fix
Date: Wed, 10 Sep 2003 13:40:57 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101341.00161.angus.sawyer@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The mwave driver requires [un]register_char from 8250.c
Make sure 8250.c gets compilied.


 drivers/char/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/Kconfig~mwave drivers/char/Kconfig
--- linux-2.6.0-test5/drivers/char/Kconfig~mwave	2003-09-10 13:36:36.399040888 
+0100
+++ linux-2.6.0-test5-angus/drivers/char/Kconfig	2003-09-10 13:37:00.508375712 
+0100
@@ -959,6 +959,7 @@ source "drivers/char/pcmcia/Kconfig"
 config MWAVE
 	tristate "ACP Modem (Mwave) support"
 	depends on X86
+	select SERIAL_8250
 	---help---
 	  The ACP modem (Mwave) for Linux is a WinModem. It is composed of a
 	  kernel driver and a user level application. Together these components

_

