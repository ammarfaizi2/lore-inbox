Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSBDRdn>; Mon, 4 Feb 2002 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSBDRde>; Mon, 4 Feb 2002 12:33:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53008 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289138AbSBDRdS>; Mon, 4 Feb 2002 12:33:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: UNDI/PXE for 2.4.x available?
Date: 4 Feb 2002 09:32:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3mgk2$q61$1@cesium.transmeta.com>
In-Reply-To: <20020204154633.E2BC267F3@penelope.materna.de> <a3md05$ps3$1@cesium.transmeta.com> <20020204170844.2AB5667F1@penelope.materna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020204170844.2AB5667F1@penelope.materna.de>
By author:    Tobias Wollgam <tobias.wollgam@materna.de>
In newsgroup: linux.dev.kernel
>
> We want to install PCs over ethernet with PXE. For the first boot from 
> net we have nothing than the network, we don't know the hardware, so an 
> UNDI in the kernel would be perfect. IMHO
> 
> > I think you'll have that problem with any UNDI driver; in either case
> > I suspect that (a) performance will stink no matter what 
> 
> That's ok for the things we will do.
> 
> > and (b) it won't work properly with SMP unless you apply really
> > heavy locking.
> 
> Does it matter in our case?
>  

Probably not.

> 
> > The PXE people at Intel really seems enamored with the idea of using
> > the UNDI stack all the way into the operating system; 
> 
> We need it not to run an operating system, we need it for the 
> installation of an operating system.
> 
> On the other hand, UNDI will deliver a network driver for all PXE-cards 
> that come up before there is any direct hardware support. (Ok, then b 
> matters)
> 

In theory.  In practice, from having dealt with enough PXE stacks, I
would say that it is more likely you're going to have problems getting
the UNDI drivers to work in a Linux environment than you will find
that a fully equipped kernel lacks the drivers you need, especially
since you can update the kernel on the server as needed.  There has
been a shakeout in the NIC world, and aren't anywhere near as many in
use now as there was a few years ago -- and anything before then isn't
going to have PXE.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
