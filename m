Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278221AbRJSABR>; Thu, 18 Oct 2001 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278222AbRJSABH>; Thu, 18 Oct 2001 20:01:07 -0400
Received: from cs.columbia.edu ([128.59.16.20]:24965 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S278221AbRJSAA6>;
	Thu, 18 Oct 2001 20:00:58 -0400
Date: Thu, 18 Oct 2001 20:01:31 -0400 (EDT)
From: Shaya Potter <spotter@cs.columbia.edu>
To: <arjan@fenrus.demon.nl>
cc: Shaya Potter <spotter@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <E15uKqE-0004VS-00@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.33.0110181958290.10380-100000@prague.clic.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


actually, it seems on my system, if my system goes to sleep (haven't 
played around with it enough to figure out how to prevent that from 
happening), it seems to crash on "wakeup" if I use the xircom_tulip_cb, 
while the xircom_cb doesn't have that problem.

other thing is, xircom_tulip_cb used to work on my system (2.4.10) (xircom 
realport card, rebranded for IBM), but with 2.4.12-ac3, it can't seem to 
drive the card.  it loads fine, detects the card, but no blinky lights. 

<shrug/>

if it doesn't need promiscious mode always, shouldn't this be a module 
param?

thanks,

shaya

On Thu, 18 Oct 2001 arjan@fenrus.demon.nl wrote:

> In article <Pine.GSO.4.31.0110181725190.764-100000@diamond.cs.columbia.edu> you wrote:
> 
> > in looking through the source for the driver, it seems from the comments
> > that when the card is in interrupt handler mode, it has to turn
> > promiscious mode on.  I don't know why, but I do know that it never seems
> > to turn it off.  I basically stuck a return in the enable_promisc function
> > before it does anything, and that cleared up all my problems.
> 
> It actually doesn't need the promisc for most revisions of the card, but for
> some it seems to be really needed.
> 
> The xircom_tulip_cb driver is more advanced, and probably works well for
> your system. (It doesn't work for all cards, but I suspect that correlates
> highly with the revision that needs the promisc)
> 

