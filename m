Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272307AbTHRTrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272450AbTHRTrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:47:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:41093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272307AbTHRTrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:47:01 -0400
Date: Mon, 18 Aug 2003 12:43:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rob@landley.net
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Compiling cardbus devices monolithic doesn't work?
Message-Id: <20030818124308.73bde51c.rddunlap@osdl.org>
In-Reply-To: <200308181534.37586.rob@landley.net>
References: <200308172158.34498.rob@landley.net>
	<20030818084411.A26743@flint.arm.linux.org.uk>
	<200308181534.37586.rob@landley.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 15:34:37 -0400 Rob Landley <rob@landley.net> wrote:

| Ahem, second attempt:
| 
| On Monday 18 August 2003 03:44, Russell King wrote:
| 
| > You still need to use cardmgr to bind the driver to the device.
| > It seems to work for me here on SA11x0 platforms, and I'm not aware
| > of it breaking at any point in the 2.5 series.
| >
| > While it is true that Cardbus devices plugged into cardbus slots do
| > not need cardmgr, PCMCIA devices still do.
| 
| The hotplug scripts from RH9 are there and seem happy, I thought cardmgr was 
| called from them.  (The same setup works in 2.4.21, albeit with modules 
| enabled.  I should compile a monolithic 2.4 kernel and see what it does...)
| 
| > > (P.S.  And while I'm at it, what's the relationship between orinoco_cs,
| > > orinoco, and hermes?  The /proc/modules dependency tree thing says
| > > they're using each other in a chain.  Probably true, just a bit odd, I
| > > thought. Couldn't figure out which driver I needed, compiled all three,
| > > and it loaded ALL of them.  Can't complain, the card works under 2.4. 
| > > This is just a random "huh?")
| >
| > IIRC hermes provides the low level interface to the device, orinoco
| > provides the interface between it and the network stack, and orinoco_cs
| > provides a bridge between the PCMCIA subsystem and orinoco.
| 
| Now I'm confused.  I thought the _cs on the end was short for "cardbus"...

I would have guess that it was for Card Services... (a PCMCIA software
component, at least architecturally).

--
~Randy
"Everything is relative."
