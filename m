Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUAPAXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUAPAXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:23:23 -0500
Received: from palrel13.hp.com ([156.153.255.238]:53741 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263711AbUAPAXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:23:22 -0500
Date: Thu, 15 Jan 2004 16:23:17 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.4.25
Message-ID: <20040116002317.GA2837@bougret.hpl.hp.com>
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

        Hi Marcelo,

	Two IrDA patch that I want to submit for 2.4.25.
	It is basically the backport of two drivers from the 2.6.X
kernel that are very popular amongst IrDA users. I reverted back the
alloc_irdadev patch in the VIA driver so it matches other 2.4.X
drivers.
	Those patches have been tested in 2.6.X and 2.4.24, and only
impact the driver themselves, so are safe.

	Thanks in advance.

	Jean

------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir244_nsc_39x-2.diff :
~~~~~~~~~~~~~~~~~~~~
		<Original patch from Jan Frey>
	o [FEATURE] Add support for NSC PC8739x chipset	(IBM A/R31 laptops)

ir244_via-ircc-5.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Frank Liu/VIA and Oliver Neukum>
	o [FEATURE] driver for IrDA integrated in VIA chipsets (AMD laptops)
	o [CORRECT] Use PCI table for probing
	o [FEATURE] Beautify source code
