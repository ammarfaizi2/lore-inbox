Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSDDAJM>; Wed, 3 Apr 2002 19:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSDDAJF>; Wed, 3 Apr 2002 19:09:05 -0500
Received: from ecs.fullerton.edu ([137.151.27.1]:31927 "EHLO
	titan.ecs.fullerton.edu") by vger.kernel.org with ESMTP
	id <S312525AbSDDAIx>; Wed, 3 Apr 2002 19:08:53 -0500
Date: Wed, 3 Apr 2002 16:08:45 -0800 (PST)
From: Denny Gudea <ekay@ecs.fullerton.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x.c - kernel message explosion (fwd)
In-Reply-To: <3CAB9518.5090409@mandrakesoft.com>
Message-ID: <Pine.GSO.4.33.0204031602090.20758-100000@titan.ecs.fullerton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you are correct.. i am a newbie.. my debug is set to the default (1)i
didnt see that last vortex_debug..

the machine i have this nic on visits several networks.. as this code
suggests, maybe this is a more serious error than i thought. this machine
has been tested in several networks, and seems to be happening everywhere
for me.

can you guys give me any clues to finding the culprit on the
network? the condition is easily created for me..

thanks for your help

denny gudea
ekay@ecs.fullerton.edu

On Wed, 3 Apr 2002, Jeff Garzik wrote:

> Denny Gudea wrote:
> > i believe the problem resides when it tests for the debug level:
> >
> > 	          if (vortex_debug > 2
> >                         || (tx_status != 0x88 && vortex_debug > 0)) {
> >
> > the || operator should be a && because we only want to print the error
> > message if debug is greater than 2 and the transmit status is not what it
> > should be.
>
>
>
> the test looks ok...  it prints if the status is not what it should be,
> if vortex_debug is 1 or 2, and unconditionally prints the status if
> vortex_debug is 3 or greater.
>
> What is your vortex_debug setting?
>
> 	Jeff
>
>
>
>

