Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbRDVVUn>; Sun, 22 Apr 2001 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135335AbRDVVUh>; Sun, 22 Apr 2001 17:20:37 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:61707 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135320AbRDVVUY>; Sun, 22 Apr 2001 17:20:24 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104222120.XAA04041@green.mif.pg.gda.pl>
Subject: [PATCH] CONFIG_PPP_FILTER in -ac12 / -pre6
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (kernel list)
Date: Sun, 22 Apr 2001 23:20:46 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

CONFIG_PPP_FILTER depends on CONFIG_FILTER (2.4.4-pre6, 2.4.3-ac12)
[ sk_run_filter(), ...]
So updated Config.in ...

Andrzej

diff -ur drivers/net/Config.in.old drivers/net/Config.in
--- drivers/net/Config.in.old	Sun Apr 22 14:48:51 2001
+++ drivers/net/Config.in	Sun Apr 22 16:24:10 2001
@@ -227,7 +227,7 @@
 tristate 'PPP (point-to-point protocol) support' CONFIG_PPP
 if [ ! "$CONFIG_PPP" = "n" ]; then
    dep_bool '  PPP multilink support (EXPERIMENTAL)' CONFIG_PPP_MULTILINK $CONFIG_EXPERIMENTAL
-   bool '  PPP filtering' CONFIG_PPP_FILTER
+   dep_bool '  PPP filtering' CONFIG_PPP_FILTER $CONFIG_FILTER
    dep_tristate '  PPP support for async serial ports' CONFIG_PPP_ASYNC $CONFIG_PPP
    dep_tristate '  PPP support for sync tty ports' CONFIG_PPP_SYNC_TTY $CONFIG_PPP
    dep_tristate '  PPP Deflate compression' CONFIG_PPP_DEFLATE $CONFIG_PPP


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
