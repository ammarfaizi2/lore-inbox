Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRLBNXW>; Sun, 2 Dec 2001 08:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277918AbRLBNXM>; Sun, 2 Dec 2001 08:23:12 -0500
Received: from fungus.teststation.com ([212.32.186.211]:15367 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S277713AbRLBNXB>; Sun, 2 Dec 2001 08:23:01 -0500
Date: Sun, 2 Dec 2001 14:22:56 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: Missing Configure,help entries need filling in
In-Reply-To: <20011201122608.A9983@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0112021407280.27659-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001, Eric S. Raymond wrote:

> We're down to 120 missing help entries.  If you can fill some of these
> in, please send me a patch for Configure.help.
...
> VIA_RHINE_MMIO

This bit was included in the original patch.
Do you want it as a patch for 2.4 also or do you merge by-hand anyway?

/Urban


diff -urN -X exclude linux-2.5.1-pre5-orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.5.1-pre5-orig/Documentation/Configure.help	Sat Dec  1 17:24:59 2001
+++ linux/Documentation/Configure.help	Sun Dec  2 14:10:42 2001
@@ -11002,6 +11002,17 @@
   a module, say M here and read <file:Documentation/modules.txt> as
   well as <file:Documentation/networking/net-modules.txt>.
 
+VIA Rhine MMIO support (EXPERIMENTAL)
+CONFIG_VIA_RHINE_MMIO
+  This instructs the driver to use PCI shared memory (MMIO) instead of
+  programmed I/O ports (PIO). Enabling this gives an improvement in
+  processing time in parts of the driver.
+
+  It is not known if this works reliably on all "rhine" based cards,
+  but it has been tested successfully on some DFE-530TX adapters.
+
+  If unsure, say N.
+
 Davicom DM910x/DM980x support
 CONFIG_DM9102
   This driver is for DM9102(A)/DM9132/DM9801 compatible PCI cards from

