Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUAHCcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUAHCcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:32:04 -0500
Received: from palrel11.hp.com ([156.153.255.246]:40340 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263472AbUAHCcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:32:00 -0500
Date: Wed, 7 Jan 2004 18:31:59 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: IrDA patches for 2.6.X
Message-ID: <20040108023159.GA13620@bougret.hpl.hp.com>
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

	As promised, here are the IrDA patches that are good to go in
the kernel. The last one is the IrCOMM fix that you say you wanted in
your kernel. The sir-dev fixes are also critical to finish the work on
SIR dongle drivers. I've kept a few more less tested patches for later.
        Patches tested on 2.6.0, please push to Linus...

        Thanks...

        Jean

----------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir2609_irlap_final_timer-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Proper calculation for F-timer. Improve interoperability.

irXXX_sirdev_txlock.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CRITICA] Fix a potential dealock in sir-dev state machine
	o [FEATURE] Make sir-dev locking compatible with irport

irXXX_sirdev_rawmode.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Apply *after* irXXX_sirdev_txlock.diff patch>
		<Patch from Martin Diehl>
	o [CORRECT] Fix sir-dev 'raw' mode for sir dongles that need it

irXXX_ircomm_alias.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [FEATURE] Add module alias for IrCOMM pseudo serial device.

ir2609_afirda_max_string.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Fix a gcc warning

ir260_ircomm_detach_lock.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix IrCOMM Oops at disconnect (local_bh_enable)

