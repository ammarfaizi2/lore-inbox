Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRIQTT6>; Mon, 17 Sep 2001 15:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273663AbRIQTTs>; Mon, 17 Sep 2001 15:19:48 -0400
Received: from 20dyn247.com21.casema.net ([213.17.90.247]:16139 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S272593AbRIQTTm>; Mon, 17 Sep 2001 15:19:42 -0400
Message-Id: <200109171919.VAA09385@cave.bitwizard.nl>
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
In-Reply-To: <20010904154221.J19621@arthur.ubicom.tudelft.nl> from Erik Mouw
 at "Sep 4, 2001 03:42:21 pm"
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Date: Mon, 17 Sep 2001 21:19:59 +0200 (MEST)
CC: Rastislav Stanik <rastos@woctni.sk>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Tue, Sep 04, 2001 at 02:57:10PM +0200, Rastislav Stanik wrote:
> > I'm developing specialized plotter.
> > The moving parts of the plotter are controlled by ISA card that generates
> > (and responds to) interrupts on each movement or printing event.
> > The interrupts can be generated quite fast; up to frequency of 4kHz.
> 
> I just made a driver for a couple of serial A/Ds that runs at 2kHz on a
> StrongARM platform. The system doesn't have any problems to keep up
> with that frequency, so I think 4kHz would still be OK.

I've had a waveform generator generate a square wave into an interrupt
input of an ISA card. At 120k interrupts per second the system would
noticably slow down, and at 140k interrupts it would stop. (and
continue once the interrupt frequency was down below the threshold
again).

So, you have about a factor of 25 of margin beyond "4kHz".

			Roger. 
-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
