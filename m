Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbTGIXdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbTGIXdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:33:54 -0400
Received: from palrel11.hp.com ([156.153.255.246]:152 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S268703AbTGIXdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:33:41 -0400
Date: Wed, 9 Jul 2003 16:48:19 -0700
To: Jeff Garzik <jgarzik@pobox.com>, Martin Diehl <lists@mdiehl.de>,
       irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches for 2.5.X
Message-ID: <20030709234819.GA12747@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Here are a bunch of patches to push to 2.5.X alongside the
patches from Martin. As you can see, many trivial fixes to the core,
and some more driver work. I'm quite pleased that VIA contributed a
driver for their hardware.
	Patches tested on 2.5.74, been a few weeks on my web page
without anybody complaining.

	Thanks in advance...

	Jean

----------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir250_include_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Cleanup cruft from <linux/irda.h>

ir250_struct_check.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Suggested by Russell King>
	o [FEATURE] Add struct size check for buggy compilers

ir250_irttp_leak.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Stanford checker>
	o [CORRECT] fix two additional potential skb leaks in IrTTP.

ir254_irnet_cast-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Suggested by David S. Miller>
	o [FEATURE] remove pointer casting in IrNET debug code missed by David.

ir254_ircomm_devfs.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Martin Diehl>
	o [CRITICA] fix IrCOMM bogus device names with devfs

ir254_setup_dma_fix-3.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Make ISA drivers depend on ISA. This is the consequence
		from David's change to setup_dma().
	o [CORRECT] Make new dongle drivers depend on sir-dev (they require it)
	o [FEATURE] Make old dongle drivers depend on irtty/irport
	o [FEATURE] irda-usb driver is no longer experimental

ir254_irda-usb_endian-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Add USB-ID of new device
		<Original patch from Jacek Jakubowski>
	o [CORRECT] Endianess fixes (for PPC and co.)

ir254_nsc_39x-1.diff :
~~~~~~~~~~~~~~~~~~~~
		<Original patch from Jan Frey>
	o [FEATURE] Add preliminary support for NSC PC8739x chipset
		(IBM R31 laptops)

ir254_via_ircc-1.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Joseph Chan/VIA>
	o [FEATURE] driver for IrDA integrated in VIA chipsets
