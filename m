Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSLHA12>; Sat, 7 Dec 2002 19:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSLHA12>; Sat, 7 Dec 2002 19:27:28 -0500
Received: from mta2n.bluewin.ch ([195.186.4.220]:38607 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264975AbSLHA11>;
	Sat, 7 Dec 2002 19:27:27 -0500
Date: Sun, 8 Dec 2002 01:34:56 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5][Trivial] VIA Rhine Kconfig entry
Message-ID: <20021208003456.GA12234@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix and update VIA Rhine description at least for 2.5 (I'll do 2.4, too, if
there's interest). Removed "experimental" flag for Rhine MMIO while I was
at it. Just barely resisted the temptation to make VIA Rhine conflict with
IO-APIC -- that seems to emerge as a fatal combo.

Please apply.

Roger

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Kconfig-via-rhine.diff"

--- linux-2.5.50/drivers/net/Kconfig.orig	Sun Dec  8 00:29:44 2002
+++ linux-2.5.50/drivers/net/Kconfig	Sun Dec  8 01:00:40 2002
@@ -1426,8 +1426,10 @@
 	tristate "VIA Rhine support"
 	depends on NET_PCI && PCI
 	help
-	  If you have a VIA "rhine" based network card (Rhine-I (3043) or
-	  Rhine-2 (VT86c100A)), say Y here.
+	  If you have a VIA "Rhine" based network card (Rhine-I (VT86C100A),
+	  Rhine-II (VT6102), or Rhine-III (VT6105)), say Y here. Rhine-type
+	  Ethernet functions can also be found integrated on South Bridges
+	  (e.g. VT8235).
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
@@ -1436,15 +1438,15 @@
 	  well as <file:Documentation/networking/net-modules.txt>.
 
 config VIA_RHINE_MMIO
-	bool "Use MMIO instead of PIO (EXPERIMENTAL)"
-	depends on VIA_RHINE && EXPERIMENTAL
+	bool "Use MMIO instead of PIO"
+	depends on VIA_RHINE
 	help
 	  This instructs the driver to use PCI shared memory (MMIO) instead of
 	  programmed I/O ports (PIO). Enabling this gives an improvement in
 	  processing time in parts of the driver.
 
-	  It is not known if this works reliably on all "rhine" based cards,
-	  but it has been tested successfully on some DFE-530TX adapters.
+	  It is not known if this works reliably on all "Rhine" based cards,
+	  but it has been tested successfully on several adapters.
 
 	  If unsure, say N.
 

--FL5UXtIhxfXey3p5--
