Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUBJBJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUBJBJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:09:08 -0500
Received: from palrel11.hp.com ([156.153.255.246]:51850 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265530AbUBJBJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:09:02 -0500
Date: Mon, 9 Feb 2004 17:08:59 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       shemminger@osdl.org
Subject: More small IrDA patches for 2.6.3
Message-ID: <20040210010859.GA673@bougret.hpl.hp.com>
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

	People seems to have appreciated the IrDA driver update you
pushed into 2.6.2. Now, it's time for me to push more IrDA patches ;-)
	If the last batch was the "Martin Diehl edition", this one is
definitely the "Stephen Hemminger" edition, as he is doing a great job
reviewing the IrDA code. All patches tested here on 2.6.2.
	Thanks in advance...

	Jean

---------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir262_ultra_sendto.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
	o [CORRECT] Always initialise Ultra packet/header size.
	o [CORRECT] Don't allow Ultra send on unbound sockets if no
		dest address is given.
	o [FEATURE] Properly support Ultra sendto on unbound sockets.

ir260_irlap_discon_pend_race.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Don't drop IrLAP connection is we *just* received an
		incomming IrLMP connection request.

ir262_notifier.diff :
~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] remove unused code : device notifier handler.

ir262_irq_retval_nsc.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in nsc-ircc driver.

ir262_irq_retval_ali.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in ali-ircc driver.

ir262_irq_retval_smsc2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in smsc-ircc2 driver.

ir262_irq_retval_via.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in via-ircc driver.

ir262_irq_retval_w83977af.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [CORRECT] Better handling of shared IRQs in w83977af_ir driver.

