Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270697AbTGUTqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270699AbTGUTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:46:50 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:50086 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S270697AbTGUTqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:46:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: no_spam@ntlworld.com
To: "Kathy Frazier" <kfrazier@mdc-dayton.com>, linux-kernel@vger.kernel.org
Subject: Re: Missing interrupts?
Date: Mon, 21 Jul 2003 21:00:54 +0100
User-Agent: KMail/1.4.3
References: <PMEMILJKPKGMMELCJCIGCEFOCDAA.kfrazier@mdc-dayton.com>
In-Reply-To: <PMEMILJKPKGMMELCJCIGCEFOCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307212100.54433.no_spam@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kathy,

How did you check that the driver was asserting the interrupt? (do you have an 
additional way of monitoring it?)  I have yet to fully investigate my problem 
and an additional tool to check if my board is actually asserting the 
interrupt (and to find out how far it gets) would be very handy,

Thanks for the suggestions - more notes below

Thanks,

SA



> ">>"s truncated....
> Futhermore, it appears that things on the motherboard are is such a bad
> state, that no other interrupts are getting through (keyboard, mouse,
> network, etc).  This same board and driver works fine in a Pentium 3
> system.
>
> >Machines test where everything worked: kernels 2.4.18-10 and 2.4.18-24.8.0
> > on athlon based PCs
> >
> >Machine where interrupts failed to appear: kernel 2.4.18-3 on a pentium 4.
>
> Are you running these tests using the same board?  You might try moving the
> board for this device driver from the athlon PC to the pentium 4 PC just to
> insure it is not a problem with the board.

Same board each time

>...
>....
> Is the value in pi_stage.interrupt assigned from the irq element of the
> pci_dev structure (returned by pci_find_device routine)?  This is the
> preferred way to obtain your IRQ rather than look directly at your device's
> config space.

I am currently inspecting the board config space - I will modify and test - is 
it possible for the config space to be "wrong". 

> Even though you are indicating that you will share the IRQ, have you tried
> adjusting BIOS settings or moving board to another slot to try to establish
> a unique IRQ for yourself?  That would at least prevent another device
> driver from getting in your way.

The card and driver share "nicely" with a random assortment of hardware on the 
"good" machines - I will try to get it a unique (or at least different 
interrupt) on the bad machine (it current shares with usb on int 9 which 
never seems to get any interrupts) and see how this pans out

> Just curious:  Are you receiving any interrupts at all in the pentium 4
> system?  Or is it running for awhile and then missing some?  Does a missing
> interrupt hang your system?

The bad computer function fine in everyway except for the missing interrupts 
from my card - the card and driver are robust in the sense that they can live 
without the interrupts (performance can suffer though) so this problem is in 
the category annoying and anomolous rather than fatal.

Ta SA.

