Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTGNQtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270683AbTGNQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:47:48 -0400
Received: from palrel12.hp.com ([156.153.255.237]:34691 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S270604AbTGNQqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:46:09 -0400
Date: Mon, 14 Jul 2003 10:00:56 -0700
To: Sven Dowideit <svenud@ozemail.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mis-identified cisco aironet pccard (and Re: hang with pcmcia wlan card)
Message-ID: <20030714170056.GH22238@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1058100731.778.5.camel@localhost> <20030714164852.GC22238@bougret.hpl.hp.com> <20030714175243.B1076@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714175243.B1076@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 05:52:43PM +0100, Russell King wrote:
> On Mon, Jul 14, 2003 at 09:48:52AM -0700, Jean Tourrilhes wrote:
> > On Sun, Jul 13, 2003 at 10:57:58PM +1000, Sven Dowideit wrote:
> > > Hi,
> > > i just noticed with 2.5.75 that if I boot with the cisco airo 340 wifi
> > > card in, this kernel thinks it is a memory card. when i remove it and
> > > re-insert it after boot, it then works .... see the following log :) I
> > > am running debian unstable, on an ibm t21 pIII-850 notebook
> > > 
> > > the cisco card works at boot time using 2.5.70.
> > > 
> > > as for the two patches for the pcmcia hang, this time i am running the
> > > one Russell posted, but the result is the same for the other.
> > > 
> > > as i shutdown i get a number of kernel stack dumps related to airo_stat,
> > > but the machine reboots before i can do anything about them..(what do i
> > > need to log them?)
> > > 
> > > if i replace the cisco card with a dlink orinoco card, it get recognised
> > > correctly at boot. 
> > > 
> > > to make this story more interesting, i put the thinkpad into the docking
> > > station and the cisco card into the dock's pccard (something that has
> > > locked up 2.5 every time that i tried it), and the card is recogised
> > > correctly at boot, and runs fine (there was a kernel stack dump during
> > > boot - *what do i need to do to get them logged?*)
> > > 
> > > thanks for the great work!
> > > 
> > > sven
> > 
> > 	I've seen this bug come and go in the 2.5.X serie. I believe
> > this is because of the various work happening in the Pcmcia
> > layer. Please contact Dominik Brodowski <linux@brodo.de>.
> 
> I think this may be my fault, but I haven't head a clear bug report for
> it yet; I've only seen vague references to something going wrong with
> aero cards on lkml yesterday, referring to what seemed to be a non-
> existent thread.

	Personally, I had this erratic problem around 2.5.6X, but it
was erratic, so at the next boot it disapeared. Since 2.5.72, I've not
seen it, so I assumed it was fixed.
	You probably know already the memory_cs is bound to any card
which doesn't have any CIS.

> Russell King

	Jean
