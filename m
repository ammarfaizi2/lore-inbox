Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDDMOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDDMOy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 08:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDDMOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 08:14:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:18870 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261226AbVDDMOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 08:14:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16977.12215.621136.359066@alkaid.it.uu.se>
Date: Mon, 4 Apr 2005 14:14:47 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Don Guy" <mostly_harmless@sympatico.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: v2.4.29 won't compile with PCI support disabled
In-Reply-To: <BAYC1-PASMTP03A4A4DD478BB2FC220CE1E13B0@cez.ice>
References: <BAYC1-PASMTP03A4A4DD478BB2FC220CE1E13B0@cez.ice>
	<002401c53900$9a47b0e0$1d2aa8c0@stormie>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Guy writes:
 > PROBLEM:
 > 
 > Attempts to compile v2.4.29 with PCI support disabled result in the
 > following errors:
 > 
 > drivers/char/char.o: In function `siig10x_init_fn':
 > drivers/char/char.o(.text.init+0x12cd): undefined reference to
 > `pci_siig10x_fn'
 > drivers/char/char.o: In function `siig20x_init_fn':
 > drivers/char/char.o(.text.init+0x12ed): undefined reference to
 > `pci_siig20x_fn'
 > 
 > It has been suggested that enabling PCI support in the kernel will make this
 > go away however a) enabling PCI support on a 486 which only has ISA & VLB is
 > downright silly, and b) a test run with CONFIG_PCI=y resulted in a plethora
 > of other errors.

Presumably this is because of other CONFIG options which are still
enabled but don't work w/o CONFIG_PCI. So please post your .config.

Both 2.4 and 2.6 kernels with CONFIG_PCI=n work Ok(*) on my 486.

/Mikael

(*) 2.6 kernels need HZ=100 and broken Fedora needs RDTSC emulation.
