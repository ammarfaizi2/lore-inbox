Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269617AbSKEBqx>; Mon, 4 Nov 2002 20:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269620AbSKEBqx>; Mon, 4 Nov 2002 20:46:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51166 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S269617AbSKEBqw>;
	Mon, 4 Nov 2002 20:46:52 -0500
Date: Mon, 4 Nov 2002 17:53:26 -0800
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches for 2.5.X on the way...
Message-ID: <20021105015326.GA8849@bougret.hpl.hp.com>
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

	As promised earlier, the new irtty driver ! This new driver
should work properly with the new serial driver in 2.5.X. As the old
irtty, the most used driver, was broken with the new serial driver,
you can guess that this is a pretty important update for most users...
	This has been tested in 2.5.44 and 2.5.46. There is still more
work to be done around the new irtty driver (like converting other
dongle drivers), but at least this should get most people going. I
will also probably remove the old drivers before 2.6.X proper (but we
need a new irport first).
	I still have other goodies in my patch queue, but they will
wait for the next update.
	Have fun...

	Jean

-----------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir255_irtty-sir-1.diff :
----------------------
	        <Following patch from Martin Diehl>
	o [CRITICA] Do all serial driver config change in process context
	o [CORRECT] Safe registration of dongle drivers
	o [FEATURE] Rework infrastructure of SIR drivers
	o [CORRECT] Port irtty driver to new SIR infrastructure
	o [CORRECT] Port esi/actisys/tekram driver to new SIR infrastructure
		<Note : there is still some more work to do around SIR drivers,
		 such as porting other drivers to the new infrastructure, but
		 this is functional and tested, and old irtty is broken>

ir254_donauboe_init.diff :
------------------------
		<Thanks to Adrian Bunk>
	o [FEATURE] Fix exported function name to avoid clash with toshoboe

ir256_packet_type.diff :
----------------------
		<Thanks to Martin Diehl>
	o [CORRECT] Handle non-linear and shared skbs
	o [CORRECT] Tell kernel we can handle multithreaded receive
		<Of course, this has been tested extensively on SMP>

