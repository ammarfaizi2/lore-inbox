Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbVCEAgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbVCEAgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbVCEAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:30:38 -0500
Received: from palrel10.hp.com ([156.153.255.245]:39134 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263339AbVCEAXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:23:41 -0500
Date: Fri, 4 Mar 2005 16:23:39 -0800
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.12-rc1
Message-ID: <20050305002339.GA23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi David,

	More trivial fixes in various places of the IrDA stack and
driver, no biggies. Freshly tested on 2.6.11, most have been on my web
pages for a while.
	This should go in 2.6.12-rc1.
	Thanks !

	Jean

---------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir261_irnet_poll_fix-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] poll would improperly exit when the discovery log was empty
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir261_irda-usb_sysfs-kill_urb-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Forgot to convert a few usb_unlink_urb() in usb_kill_urb()
		<Patch from John K. Luebs>
	o [FEATURE] Proper sysfs support
Signed-off-by: John K. Luebs <jkluebs@lu...>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir261_stir_turn.diff :
~~~~~~~~~~~~~~~~~~~~
		<Patch from John K. Luebs>
	o [CORRECT] Proper turnaround computations in the stir4200 driver
	o [CORRECT] Take care of Tx packet without IrDA metadata (speed)
Signed-off-by: John K. Luebs <jkluebs@lu...>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_via_devexit.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Randy Dunlap>
	o [CORRECT] Make exit code properly in VIA driver
Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir261_connect_lsap-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Iavor Fetvadjie>
	o [FEATURE] allow IrDA socket to connect on arbitrary LSAPs
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir261_nsc_38x.diff :
~~~~~~~~~~~~~~~~~~
		<Original patch from Steffen Pingel>
	o [FEATURE] support NSC PC8738x chipset (IBM x40 & ...)
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

ir261_ircomm_write_cleanup.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] cleanup some construct obsoleted by Linus's patch
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>

irXXX_irport_exports.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Adrian Bunk>
	o [FEATURE] make needlessly global code static
	o [FEATURE] remove unneeded EXPORT_SYMBOL's from irport.c
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>
