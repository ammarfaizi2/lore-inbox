Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRCHEhr>; Wed, 7 Mar 2001 23:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131270AbRCHEh2>; Wed, 7 Mar 2001 23:37:28 -0500
Received: from d147.as5200.mesatop.com ([208.164.122.147]:50056 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131267AbRCHEhS>; Wed, 7 Mar 2001 23:37:18 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Wed, 7 Mar 2001 21:40:26 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] remove CONFIG_PCMCIA_SERIAL_CB from Configure.help
MIME-Version: 1.0
Message-Id: <01030721402601.02555@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that use of CONFIG_PCMCIA_SERIAL_CB was removed in
2.4.2-ac12.  The two files affected were Config.in  and the Makefile 
in drivers/char/pcmcia.  

If in fact this option is now history, the reference in Configure.help should also 
be history.  I noticed this when the number of Configure.help "orphans" increased
from 40 to 41 recently.

Here is the patch to do this, against 2.4.2-ac14.

Steven

--- linux/Documentation/Configure.help.orig     Wed Mar  7 21:13:56 2001
+++ linux/Documentation/Configure.help  Wed Mar  7 21:14:52 2001
@@ -2464,20 +2464,6 @@
   a module, say M here and read Documentation/modules.txt. If unsure,
   say N.
 
-CardBus serial device support
-CONFIG_PCMCIA_SERIAL_CB
-  Say Y here to enable support for CardBus serial devices, including
-  serial port cards, modems, and the modem functions of multi-function
-  ethernet/modem devices. (CardBus cards are the newer and better 
-  version of PCMCIA- or PC-cards: credit card size devices often 
-  used with laptops.)
-
-  This driver is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called serial_cb.o. If you want to compile it as
-  a module, say M here and read Documentation/modules.txt. If unsure,
-  say N.
-
 /dev/agpgart (AGP Support) (EXPERIMENTAL)
 CONFIG_AGP
   AGP (Accelerated Graphics Port) is a bus system mainly used to
