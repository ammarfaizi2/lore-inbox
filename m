Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTLLW1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLLW1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:27:09 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6605 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262116AbTLLW1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:27:03 -0500
Date: Fri, 12 Dec 2003 23:26:55 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@surriel.com>, linux-tr@linuxtr.net,
       jschlst@samba.org, cgoos@syskonnect.de, mid@auk.cx, phillim@amtrak.com,
       jochen@scram.de
Subject: [PATCH][TRIVIAL] dep_tristate wants 3 arguments (fwd)
Message-ID: <20031212222655.GH1825@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the trivial patch by Rik forwarded below still applies against 
2.4.24-pre1.

Please apply
Adrian


----- Forwarded message from Rik van Riel <riel@surriel.com> -----

Date:	Mon, 13 Oct 2003 11:10:36 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] dep_tristate wants 3 arguments

The tokenring Config.in has dep_tristate statements with only two
arguments. Add the obvious third argument.

diff -urNp linux-5110/drivers/net/tokenring/Config.in linux-10010/drivers/net/tokenring/Config.in
--- linux-5110/drivers/net/tokenring/Config.in
+++ linux-10010/drivers/net/tokenring/Config.in
@@ -21,10 +21,10 @@ if [ "$CONFIG_TR" != "n" ]; then
    dep_tristate '  3Com 3C359 Token Link Velocity XL adapter support' CONFIG_3C359 $CONFIG_TR $CONFIG_PCI
    tristate '  Generic TMS380 Token Ring ISA/PCI adapter support' CONFIG_TMS380TR
    if [ "$CONFIG_TMS380TR" != "n" ]; then
-      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI
-      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA
-      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI
-      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA
+      dep_tristate '    Generic TMS380 PCI support' CONFIG_TMSPCI $CONFIG_PCI $CONFIG_TMS380TR
+      dep_tristate '    Generic TMS380 ISA support' CONFIG_TMSISA $CONFIG_ISA $CONFIG_TMS380TR
+      dep_tristate '    Madge Smart 16/4 PCI Mk2 support' CONFIG_ABYSS $CONFIG_PCI $CONFIG_TMS380TR
+      dep_tristate '    Madge Smart 16/4 Ringnode MicroChannel' CONFIG_MADGEMC $CONFIG_MCA $CONFIG_TMS380TR
    fi
    if [ "$CONFIG_ISA" = "y" -o "$CONFIG_MCA" = "y" ]; then
       tristate '  SMC ISA/MCA adapter support' CONFIG_SMCTR
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

