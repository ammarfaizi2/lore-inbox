Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUCLRDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 12:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbUCLRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 12:03:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:43679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbUCLRDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 12:03:18 -0500
Date: Fri, 12 Mar 2004 09:01:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] move PCIBIOS access help text
Message-Id: <20040312090124.03bb3626.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at Willy's MMCONFIG proposal and didn't see help text
for MMCONFIG until I searched for it in Kconfig...


// Linux 2.6.4
// Moves PCI BIOS Access Mode help text to its top level instead
// of under PCI_GOBIOS (which is only 1 of 4 possible choices).

diffstat:=
 arch/i386/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Naurp ./arch/i386/Kconfig~pci_config ./arch/i386/Kconfig
--- ./arch/i386/Kconfig~pci_config	2004-03-10 18:55:22.000000000 -0800
+++ ./arch/i386/Kconfig	2004-03-12 08:49:31.000000000 -0800
@@ -1058,9 +1058,6 @@ choice
 	prompt "PCI access mode"
 	depends on PCI && !X86_VISWS
 	default PCI_GOANY
-
-config PCI_GOBIOS
-	bool "BIOS"
 	---help---
 	  On PCI systems, the BIOS can be used to detect the PCI devices and
 	  determine their configuration. However, some old PCI motherboards
@@ -1076,6 +1073,9 @@ config PCI_GOBIOS
 	  direct access method and falls back to the BIOS if that doesn't
 	  work. If unsure, go with the default, which is "Any".
 
+config PCI_GOBIOS
+	bool "BIOS"
+
 config PCI_GOMMCONFIG
 	bool "MMConfig"
 


--
~Randy
