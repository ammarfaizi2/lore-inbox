Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUFHVIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUFHVIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUFHVIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:08:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8917 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265316AbUFHVI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:08:28 -0400
Date: Tue, 8 Jun 2004 23:08:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [2.6 patch] add NAPI help texts
Message-ID: <20040608210816.GB460@fs.tum.de>
References: <20040604152352.GB7744@fs.tum.de> <40C6070F.8030109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C6070F.8030109@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 02:35:59PM -0400, Jeff Garzik wrote:

> patch OK, but doesn't apply cleanly

I made the patch against -mm.

Hunk #5 of the first file doesn't apply, since R8169_NAPI was added in
-mm.

Below is the same patch with the R8169_NAPI help text removed (applies 
with a few lines offset against 2.6.7-rc3).

cu
Adrian

<--  snip  -->

NAPI seems to be so self-explaining that no help texts are needed. ;-)

I combined the two help texts that were at NAPI options, and added them 
to all NAPI options.

diffstat output:
 drivers/net/Kconfig       |   70 ++++++++++++++++++++++++++++++++++++++
 drivers/net/tulip/Kconfig |   16 +++++---
 2 files changed, 81 insertions(+), 5 deletions(-)


--- linux-2.6.7-rc2-mm2-full/drivers/net/Kconfig.old	2004-06-04 17:10:43.000000000 +0200
+++ linux-2.6.7-rc2-mm2-full/drivers/net/Kconfig	2004-06-04 17:18:14.000000000 +0200
@@ -1237,6 +1237,19 @@
 config AMD8111E_NAPI
 	bool "Enable NAPI support"
 	depends on AMD8111_ETH
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config ADAPTEC_STARFIRE
 	tristate "Adaptec Starfire/DuraLAN support"
@@ -1264,6 +1277,11 @@
 	  deployed on potentially unfriendly networks (e.g. in a firewall),
 	  then say Y here.
 
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
+
 config AC3200
 	tristate "Ansel Communications EISA 3200 support (EXPERIMENTAL)"
 	depends on NET_PCI && (ISA || EISA) && EXPERIMENTAL
@@ -1451,6 +1469,19 @@
 config E100_NAPI
 	bool "Use Rx Polling (NAPI)"
 	depends on E100
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config LNE390
 	tristate "Mylex EISA LNE390A/B support (EXPERIMENTAL)"
@@ -1924,6 +1955,19 @@
 config E1000_NAPI
 	bool "Use Rx Polling (NAPI)"
 	depends on E1000
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config MYRI_SBUS
 	tristate "MyriCOM Gigabit Ethernet support"
@@ -2114,6 +2170,19 @@
 config IXGB_NAPI
 	bool "Use Rx Polling (NAPI) (EXPERIMENTAL)"
 	depends on IXGB && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 config S2IO
 	tristate "S2IO 10Gbe XFrame NIC"
@@ -2126,6 +2195,19 @@
 config S2IO_NAPI
 	bool "Use Rx Polling (NAPI) (EXPERIMENTAL)"
 	depends on S2IO && EXPERIMENTAL
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
+
+	  If in doubt, say N.
 
 endmenu
 
--- linux-2.6.7-rc2-mm2-full/drivers/net/tulip/Kconfig.old	2004-06-04 17:14:18.000000000 +0200
+++ linux-2.6.7-rc2-mm2-full/drivers/net/tulip/Kconfig	2004-06-04 17:16:07.000000000 +0200
@@ -71,10 +71,17 @@
 config TULIP_NAPI
 	bool "Use NAPI RX polling "
 	depends on TULIP
-	---help---
-	  This is of useful for servers and routers dealing with high network loads.
- 
-	  See <file:Documentation/networking/NAPI_HOWTO.txt>.
+	help
+	  NAPI is a new driver API designed to reduce CPU and interrupt load
+	  when the driver is receiving lots of packets from the card. It is
+	  still somewhat experimental and thus not yet enabled by default.
+
+	  If your estimated Rx load is 10kpps or more, or if the card will be
+	  deployed on potentially unfriendly networks (e.g. in a firewall),
+	  then say Y here.
+
+	  See <file:Documentation/networking/NAPI_HOWTO.txt> for more
+	  information.
 
 	  If in doubt, say N.
 
