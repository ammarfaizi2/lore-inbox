Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTJMPK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 11:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJMPK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 11:10:57 -0400
Received: from imladris.surriel.com ([66.92.77.98]:23995 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261771AbTJMPK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 11:10:56 -0400
Date: Mon, 13 Oct 2003 11:10:36 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] dep_tristate wants 3 arguments
Message-ID: <Pine.LNX.4.55L.0310131105560.30266@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
