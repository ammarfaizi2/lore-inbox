Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbUBZDLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUBZDLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:11:05 -0500
Received: from palrel11.hp.com ([156.153.255.246]:32663 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262622AbUBZDK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:10:56 -0500
Date: Wed, 25 Feb 2004 19:10:54 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: Bunch of janitor IrDA patches
Message-ID: <20040226031054.GA32263@bougret.hpl.hp.com>
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

	Hi Dave,

	Stephen and Martin are still working on the stir4200 driver
and will send you a patch later (we are not forgetting about
it). Meanwhile, a problem did show up in smsc-ircc2 driver that need
fixing. I'm also taking this opportunity to send you the vast majority
of janitorial patches that Stephen sent me. There's many of them, but
most are really trivial.
	Tested here on 2.6.3. Please send upwards.

	Thanks...

	Jean

-----------------------------------------------------------------
[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

irXXX_irq_retval_smsc2-fix.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Fix the handling of shared IRQs in smsc-ircc2 driver.

irXXX_usb_alloc.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Convert irda-usb to dynamic device allocation

irXXX_setup_dma.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] Rename setup_dma to irda_setup_dma
		=> reduce namepace pollution

irXXX_static_w83977af.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)

irXXX_static_irtty-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)

irXXX_static_via.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)
	o [FEATURE] remove unused code

irXXX_static_taskkick.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)

irXXX_ircomm_flags.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] volatile not needed, always use set/test_bit

irXXX_infrared_mode.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code

irXXX_dev_flags.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code

irXXX_hashbin_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code
	o [FEATURE] add const where needed

irXXX_bogus_include.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] include not needed

irXXX_txqueue_empty.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] optimise irda_device_txqueue_empty by making inline

irXXX_broken_smp.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] mark irport driver has having locking issues

ir263_dongles-12_dup_symbols.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] rename dongle entry points for consistency

