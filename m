Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965690AbWKDVES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965690AbWKDVES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965691AbWKDVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:04:18 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:27400 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965690AbWKDVER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:04:17 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc4-mm2] i2lib unused variable cleanup
Date: Sat, 4 Nov 2006 22:03:13 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042203.13341.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes this warning:

  CC      drivers/char/ip2/ip2main.o
In file included from drivers/char/ip2/ip2main.c:285:
drivers/char/ip2/i2lib.c: In function `i2Output':
drivers/char/ip2/i2lib.c:1019: warning: unused variable `rc'

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -up linux-2.6.19-rc4-orig/drivers/char/ip2/i2lib.c 
linux-2.6.19-rc4/drivers/char/ip2/i2lib.c     
--- linux-2.6.19-rc4-orig/drivers/char/ip2/i2lib.c      2006-11-04 
20:31:55.000000000 +0100
+++ linux-2.6.19-rc4/drivers/char/ip2/i2lib.c   2006-11-04 21:56:23.000000000 
+0100
@@ -1016,7 +1016,6 @@ i2Output(i2ChanStrPtr pCh, const char *p
        unsigned short channel;
        unsigned short stuffIndex;
        unsigned long flags;
-       int rc = 0;
 
        int bailout = 10;
