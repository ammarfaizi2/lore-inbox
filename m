Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTAICmX>; Wed, 8 Jan 2003 21:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTAICmX>; Wed, 8 Jan 2003 21:42:23 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:26337 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261371AbTAICmW>;
	Wed, 8 Jan 2003 21:42:22 -0500
Date: Wed, 8 Jan 2003 18:51:03 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches on the way for 2.5.55...
Message-ID: <20030109025103.GA19178@bougret.hpl.hp.com>
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

	Now that I can again test IrDA on 2.5.X, this is time to send
you my next set of IrDA patches. I've picked the most important one in
my queue, the rest will come later. Those one have been on my web page
for more than 2 months, tested on 2.5.54 and are fairly important.
	Would you mind passing that to Linus ?

	Regards,

	Jean

P.S. : Happy new year...
P.S.2 : 16bit Pcmcia still doesn't seem to be happy on 2.5.54

-------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir254_discovery_locking-2.diff :
------------------------------
	o [CRITICA] Fix remaining locking problem with discovery log
	o [CRITICA] Don't call expiry callback under spinlock
	o [FEATURE] Simplify/cleanup/optimise discovery/expiry code

ir254_driver_module_fixes-2.diff :
--------------------------------
	o [CORRECT] Use SET_MODULE_OWNER() in various IrDA drivers

ir254_new_wrapper-3.diff :
------------------------
	o [FEATURE] Properly inline in wrapper Tx path
	o [FEATURE] Rewrite/simplify/optimise wrapper Rx path
		Lower CPU overhead *and* kernel image size
	o [FEATURE] Add ZeroCopy in wrapper Rx path for drivers that support it
		I'll update drivers later on...

ir254_secondary_rr.diff :
-----------------------
	o [CORRECT] fix the secondary function to send RR and frames without
		the poll bit when it detect packet losses

ir254_ircomm_dce.diff :
---------------------
		<Patch from Jan Kiszka>
	o [CORRECT] Properly initialise IrCOMM status line (DCE settings)
