Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTENU7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTENU7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:59:37 -0400
Received: from palrel12.hp.com ([156.153.255.237]:63162 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262872AbTENU7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:59:35 -0400
Date: Wed, 14 May 2003 14:12:22 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030514211222.GA10453@bougret.hpl.hp.com>
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

Andrew Morton wrote :
> 
> Quite a lot of changes here.  Mostly additions, but some things have been
> crossed off.
> 
> Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix

	I don't like making todo list for other people, because it's
up to them to decide, but here is my wishlist for 2.6.X in term of
Wireless stuff.
	I hope those concerned will react and send you their real todo
list.

	o get latest orinoco changes from David. Linus seems timely in
picking David's changes, so I'm not worried about this one.

	o get the latest airo.c fixes from CVS. This will hopefully
fix problems people have reported on the LKML.

	o get HostAP driver in the kernel. No consolidation of the
802.11 management across driver can happen until this one is in (which
is probably 2.7.X material). I think Jouni is mostly ready but didn't
find time for it.

	o get more wireless drivers into the kernel. The most
"integrable" drivers at this point seem the NWN driver, Pavel's
Spectrum driver and the Atmel driver.

	o The last two drivers mentioned above are held up by firmware
issues (see flamewar on LKML a few days ago). So maybe fixing those
firmware issues should be a requirement for 2.6.X, because we can
expect more wireless devices to need firmware upload at startup coming
to market.
	As this firmware business seems to me not a wireless specific
issue (see for example drivers/scsi/qlogicfc_asm.c or
drivers/atm/atmsar11.data), I would prefer a generic solution to that
problem, either saying it's OK to put firmware in the kernel (with
proper licensing) or providing working technical solutions.
	My personal position is that I don't want to hold wireless
drivers in higher standard than other drivers in the kernel, and I
don't want to leave those drivers in the black hole where they
currently are.

	Have fun...

	Jean
