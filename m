Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274226AbRISWW7>; Wed, 19 Sep 2001 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274228AbRISWWu>; Wed, 19 Sep 2001 18:22:50 -0400
Received: from CPE-61-9-148-200.vic.bigpond.net.au ([61.9.148.200]:31728 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274226AbRISWWk>; Wed, 19 Sep 2001 18:22:40 -0400
Message-ID: <3BA91980.C829078B@eyal.emu.id.au>
Date: Thu, 20 Sep 2001 08:17:36 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Why the net driver for saa9730 is not a module?
Content-Type: multipart/mixed;
 boundary="------------FD18E0377FFD05C21F7A7315"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FD18E0377FFD05C21F7A7315
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The config does not offer it. Any reason?

I had no trouble building it, however I do not have the hware to check
that
all is well.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------FD18E0377FFD05C21F7A7315
Content-Type: text/plain; charset=us-ascii;
 name="2.4.10-pre12-saa9730.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.10-pre12-saa9730.patch"

--- linux/drivers/net/Config.in.orig	Wed Sep 19 22:01:44 2001
+++ linux/drivers/net/Config.in	Wed Sep 19 22:10:39 2001
@@ -192,8 +192,7 @@
       if [ "$CONFIG_OBSOLETE" = "y" ]; then
 	 dep_bool '    Zenith Z-Note support (EXPERIMENTAL)' CONFIG_ZNET $CONFIG_ISA
       fi
-      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 bool '    Philips SAA9730 Ethernet support (EXPERIMENTAL)' CONFIG_LAN_SAA9730
+	 dep_ tristate '    Philips SAA9730 Ethernet support (EXPERIMENTAL)' CONFIG_LAN_SAA9730 $CONFIG_EXPERIMENTAL
       fi
    fi
    bool '  Pocket and portable adapters' CONFIG_NET_POCKET


--------------FD18E0377FFD05C21F7A7315--

