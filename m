Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132405AbQKZQlt>; Sun, 26 Nov 2000 11:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132402AbQKZQlj>; Sun, 26 Nov 2000 11:41:39 -0500
Received: from lin-hs2-010.inetnebr.com ([209.50.4.42]:18681 "EHLO
        falcon.inetnebr.com") by vger.kernel.org with ESMTP
        id <S132396AbQKZQlZ>; Sun, 26 Nov 2000 11:41:25 -0500
Date: Sun, 26 Nov 2000 10:11:15 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: 2.4.0-test11(-ac4)/i386 configure bug
Message-ID: <20001126101115.A2502@potty.housenet>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not affected by the -ac4 patch, the file in question is not touched)

Parallel printer support (CONFIG_PRINTER) [N/m/?] (NEW) m
  Support for console on line printer (CONFIG_LP_CONSOLE) [N/y/?] (NEW)

Suggested change:

--- linux-2.4.0-test11/drivers/char/Config.in.orig	Sun Nov 26 10:05:10 2000
+++ linux-2.4.0-test11/drivers/char/Config.in	Sun Nov 26 10:05:38 2000
@@ -75,7 +75,7 @@
 fi
 if [ "$CONFIG_PARPORT" != "n" ]; then
    dep_tristate 'Parallel printer support' CONFIG_PRINTER $CONFIG_PARPORT
-   if [ "$CONFIG_PRINTER" != "n" ]; then
+   if [ "$CONFIG_PRINTER" = "y" ]; then
       bool '  Support for console on line printer' CONFIG_LP_CONSOLE
    fi
    dep_tristate 'Support for user-space parallel port device drivers' CONFIG_PPDEV $CONFIG_PARPORT
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
