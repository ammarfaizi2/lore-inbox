Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271738AbRHQWtU>; Fri, 17 Aug 2001 18:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271736AbRHQWtL>; Fri, 17 Aug 2001 18:49:11 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:56558 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S271738AbRHQWtB>; Fri, 17 Aug 2001 18:49:01 -0400
Date: Fri, 17 Aug 2001 23:48:29 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <alex.buell@tahallah.demon.co.uk>,
        =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' produces lots of errors with this .config
In-Reply-To: <E15Xs2d-0008EK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108172344000.14197-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Alan Cox wrote:

> Actually thats one of my presents. The ports are expected to provide
> their definition for struct kbd_repeat and a kbd_rate function. If the
> facility is not available then it can be defined as NULL
>
> So the sparc asm/keyboard.h if it supports no keyboard rate stuff would be
>
>
> /*
>  *	Sparc32 lacks the standard keyboard rate ioctls
>  */
>
> #define kbd_rate	NULL
>
> and it'll error out with -EINVAL

That won't fix the PCI references which seems to get compiled in if
asm/keyboard.h is included. Taking a look at it, hmm. asm-sparc/keyboard.h
seems to be for the Ultra/PCI stuff, oughtn't this be in asm-sparc64, as
sparc32 doesn't use PCI at all, unless there's something I don't know.

-- 
A pancake! I've photocopied a pancake!

http://www.tahallah.demon.co.uk

