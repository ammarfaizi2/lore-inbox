Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316603AbSFKBLB>; Mon, 10 Jun 2002 21:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSFKBIj>; Mon, 10 Jun 2002 21:08:39 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62431 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316199AbSFKBIC>;
	Mon, 10 Jun 2002 21:08:02 -0400
Date: Mon, 10 Jun 2002 17:51:05 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches on the way...
Message-ID: <20020610175105.B21783@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi Jeff,

	More fixes. Thanks to Stanford. Also, fix previous fixes.
	Patch done on 2.5.20 and verified/tested on 2.5.21.

	Regards,

	Jean

-----------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir250_headers_init-2.diff :
-------------------------
	o [FEATURE] Use new kernel init/exit style, should fix static builds
	o [FEATURE] Reduce header dependancies
						Before	After
		net/irda/.depend		14917	13617 B
		drivers/net/irda/.depend	16134	14293 B
		irda full recompile		3'13	3'10

ir250_act200l_ma600_drivers.diff :
--------------------------------
	        <Following patch from Shimizu Takuja/Gerhard Bertelsmann>
	o [FEATURE] Dongle driver for ActiSys 200L hardware
	        <Following patch from Leung/me>
	o [FEATURE] Dongle driver for Mobile Action MA600 hardware

ir250_cache_wait_data-2.diff :
----------------------------
	o [CRITICA] Fix one instance were we forgot to clear LSAP cache
	o [CORRECT] Fix a bogus conversion to wait_event()
		The socket closure would never propagate to the app

ir250_checker.diff :
------------------
	o [CORRECT] Fix two bugs found by the Stanford checker in IrCOMM

ir250_usb_cleanup-2.diff :
------------------------
	o [FEATURE] Update various comments to current state
	o [CORRECT] Handle properly failure of URB with new speed
	o [CORRECT] Don't test for (self != NULL) after using it (doh !)
	o [FEATURE] Other minor cleanups
