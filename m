Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHRXis>; Sat, 18 Aug 2001 19:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRHRXii>; Sat, 18 Aug 2001 19:38:38 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:7940 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S266263AbRHRXiX>;
	Sat, 18 Aug 2001 19:38:23 -0400
Message-Id: <200108181659.f7IGx7gg016843@sleipnir.valparaiso.cl>
qTo: alex.buell@tahallah.demon.co.uk
cc: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 'make dep' produces lots of errors with this .config 
In-Reply-To: Message from Alex Buell <alex.buell@tahallah.demon.co.uk> 
   of "Fri, 17 Aug 2001 23:48:29 +0100." <Pine.LNX.4.33.0108172344000.14197-100000@tahallah.demon.co.uk> 
Date: Sat, 18 Aug 2001 12:59:07 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell <alex.buell@tahallah.demon.co.uk> said:
> On Fri, 17 Aug 2001, Alan Cox wrote:
> > Actually thats one of my presents. The ports are expected to provide
> > their definition for struct kbd_repeat and a kbd_rate function. If the
> > facility is not available then it can be defined as NULL
> >
> > So the sparc asm/keyboard.h if it supports no keyboard rate stuff would be
> >
> >
> > /*
> >  *	Sparc32 lacks the standard keyboard rate ioctls
> >  */
> >
> > #define kbd_rate	NULL
> >
> > and it'll error out with -EINVAL
> 
> That won't fix the PCI references which seems to get compiled in if
> asm/keyboard.h is included. Taking a look at it, hmm. asm-sparc/keyboard.h
> seems to be for the Ultra/PCI stuff, oughtn't this be in asm-sparc64, as
> sparc32 doesn't use PCI at all, unless there's something I don't know.

There are lots of sparc64 _without_ PCI around (I happen to run two)
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
