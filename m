Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135944AbRDTPbc>; Fri, 20 Apr 2001 11:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135945AbRDTPbK>; Fri, 20 Apr 2001 11:31:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:46352 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135944AbRDTPbG>;
	Fri, 20 Apr 2001 11:31:06 -0400
Date: Fri, 20 Apr 2001 11:31:43 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: More Configuration.help entries
Message-ID: <20010420113143.A7187@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are courtesy of Kai Germaschewski.

--- Configure.help	2001/04/20 15:17:03	1.2
+++ Configure.help	2001/04/20 15:25:53
@@ -15540,6 +15540,16 @@
   This enables HiSax support for the AMD7930 chips on some SPARCs.
   This code is not finished yet.
 
+ELSA PCMCIA MicroLink cards
+CONFIG_HISAX_ELSA_CS
+  This enables the PCMCIA client driver for the Elsa PCMCIA MicroLink
+  card.
+
+Sedlbauer PCMCIA cards
+CONFIG_HISAX_SEDLBAUER_CS
+  This enables the PCMCIA client driver for the Sedlbauer Speed Star
+  and Speed Star II cards.
+
 PCBIT-D support
 CONFIG_ISDN_DRV_PCBIT
   This enables support for the PCBIT ISDN-card. This card is
@@ -15613,6 +15623,33 @@
   compile it as a module, say M here and read
   Documentation/modules.txt.
 
+CAPI2.0 /dev/capi20 support
+CONFIG_ISDN_CAPI_CAPI20
+  This option will provide the CAPI 2.0 interface to userspace
+  applications via /dev/capi20. Applications should use the standardized
+  libcapi20 to access this functionality. You should say Y/M here.
+
+CAPI2.0 Middleware support
+CONFIG_ISDN_CAPI_MIDDLEWARE
+  This option will enhance the capabilities of the /dev/capi20 interface.
+  It will provide a means of moving a data connection, established
+  via the usual /dev/capi20 interface to a special tty device. If you want
+  to use pppd with pppdcapiplugin to dial up to your ISP, say Y here.
+
+CAPI2.0 filesystem support
+CONFIG_ISDN_CAPI_CAPIFS_BOOL
+  This option provides a special file system, similar to /dev/pts with
+  device nodes for the special ttys established by using the middleware
+  extension above. If you want to use pppd with pppdcapiplugin to dial up
+  to your ISP, say Y here.
+
+CAPI2.0 capidrv interface support
+CONFIG_ISDN_CAPI_CAPIDRV
+  This option provides the glue code to hook up CAPI driven cards to
+  the legacy isdn4linux link layer. If you have a card which is supported
+  by a CAPI driver, but still want to use old features like ippp
+  interfaces or ttyI emulation, say Y/M here.
+
 AVM B1 ISA support
 CONFIG_ISDN_DRV_AVMB1_B1ISA
   Enable support for the ISA version of the AVM B1 card.
@@ -15633,6 +15670,11 @@
 AVM B1/M1/M2 PCMCIA support
 CONFIG_ISDN_DRV_AVMB1_B1PCMCIA
   Enable support for the PCMCIA version of the AVM B1 card.
+
+AVM B1/M1/M2 PCMCIA cs module
+CONFIG_ISDN_DRV_AVMB1_AVM_CS
+  Enable the PCMCIA client driver for the AVM B1/M1/M2
+  PCMCIA cards.
 
 AVM T1/T1-B PCI support
 CONFIG_ISDN_DRV_AVMB1_T1PCI

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Society in every state is a blessing, but government even in its best
state is but a necessary evil; in its worst state an intolerable one;
for when we suffer, or are exposed to the same miseries *by a
government*, which we might expect in a country *without government*,
our calamities is heightened by reflecting that we furnish the means
by which we suffer."
	-- Thomas Paine
