Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbQLVG4z>; Fri, 22 Dec 2000 01:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131696AbQLVG4p>; Fri, 22 Dec 2000 01:56:45 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:29199 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S131557AbQLVG4h>; Fri, 22 Dec 2000 01:56:37 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Message-ID: <862569BD.00234C86.00@smtpnotes.altec.com>
Date: Fri, 22 Dec 2000 00:23:26 -0600
Subject: 2.4.0-test13 drivers/net/pcmcia fix
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The files in drivers/net/pcmcia are skipped when configured to compile as
modules.  Here's a patch (against test13-pre4) for the Makefile:

--- linux.old/drivers/net/Makefile Thu Dec 21 22:14:46 2000
+++ linux/drivers/net/Makefile     Thu Dec 21 23:38:20 2000
@@ -8,7 +8,7 @@
 obj-n           :=
 obj-            :=

-mod-subdirs     := wan
+mod-subdirs     := pcmcia wan

 O_TARGET := net.o


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
