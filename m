Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSBMSBM>; Wed, 13 Feb 2002 13:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBMSBD>; Wed, 13 Feb 2002 13:01:03 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:47326 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S287946AbSBMSAw>; Wed, 13 Feb 2002 13:00:52 -0500
Message-Id: <200202131712.KAA02867@tstac.esa.lanl.gov>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: David Hinds <dhinds@zen.stanford.edu>
Subject: [PATCH] 2.5.4, add help texts to drivers/net/pcmcia/Config.help
Date: Wed, 13 Feb 2002 10:59:13 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/net/pcmcia/Config.in, there are two options which currently do
not have help texts in drivers/net/pcmcia/Config.help.  Here are snippets
from the Config.in for these options:

dep_tristate '  broken NS8390-cards support' CONFIG_PCMCIA_AXNET $CONFIG_PCMCIA

if [ "$CONFIG_CARDBUS" = "y" ]; then
     tristate '  Xircom CardBus support (new driver)' CONFIG_PCMCIA_XIRCOM
     tristate '  Xircom Tulip-like CardBus support (old driver)' CONFIG_PCMCIA_XIRTULIP
fi

Here is a patch to drivers/net/pcmcia/Config.help to add these help texts.

Steven

--- linux-2.5.4/drivers/net/pcmcia/Config.help.orig     Wed Feb 13 10:28:50 2002
+++ linux-2.5.4/drivers/net/pcmcia/Config.help  Wed Feb 13 10:34:10 2002
@@ -93,6 +93,18 @@
   as a module, say M here and read <file:Documentation/modules.txt>.
   If unsure, say N.

+CONFIG_PCMCIA_AXNET
+  Say Y here if you intend to attach an Asix AX88190-based PCMCIA
+  (PC-card) Fast Ethernet card to your computer.  These cards are
+  nearly NE2000 compatible but need a separate driver due to a few
+  misfeatures.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called axnet_cs.o.  If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.  If
+  unsure, say N.
+
 CONFIG_ARCNET_COM20020_CS
   Say Y here if you intend to attach this type of ARCnet PCMCIA card
   to your computer.
@@ -113,6 +125,18 @@
   The module will be called ibmtr_cs.o.  If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.

+CONFIG_PCMCIA_XIRCOM
+  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
+  It should work with most DEC 21*4*-based chips/ethercards, as well
+  as with work-alike chips from Lite-On (PNIC) and Macronix (MXIC) and
+  ASIX.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called xircom_tulip_cb.o.  If you want to compile
+  it as a module, say M here and read
+  <file:Documentation/modules.txt>. If unsure, say N.
+
 CONFIG_PCMCIA_XIRTULIP
   This driver is for the Digital "Tulip" Ethernet CardBus adapters.
   It should work with most DEC 21*4*-based chips/ethercards, as well

