Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281553AbRLAJ6w>; Sat, 1 Dec 2001 04:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284040AbRLAJ6n>; Sat, 1 Dec 2001 04:58:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281553AbRLAJ6j>; Sat, 1 Dec 2001 04:58:39 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: akpm@zip.com.au (Andrew Morton)
Date: Sat, 1 Dec 2001 10:05:55 +0000 (GMT)
Cc: davidel@xmailserver.org (Davide Libenzi), lm@bitmover.com (Larry McVoy),
        phillips@bonn-fries.net (Daniel Phillips),
        hps@intermeta.de (Henning Schmiedehausen),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <3C082FEB.98D8BE9B@zip.com.au> from "Andrew Morton" at Nov 30, 2001 05:18:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A71v-0006h9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sufficient for development of a great 1-to-4-way kernel, and
> that the biggest force against that is the introduction of
> fine-grained locking.   Are you sure about this?  Do you see
> ways in which the uniprocessor team can improve?

ccCluster seems a sane idea to me. I don't by Larry's software engineering
thesis but ccCluster makes sense simply because when you want an efficient
system in computing you get it by not pretending one thing is another.
SMP works best when the processors are not doing anything that interacts
with another CPU.

> key people get atracted into mm/*.c, fs/*.c, net/most_everything
> and kernel/*.c while other great wilderness of the tree (with
> honourable exceptions) get moldier.  How to address that?

Actually there are lots of people who work on the driver code nowdays
notably the janitors. The biggest problem there IMHO is that when it comes
to driver code Linus has no taste, so he keeps accepting driver patches
which IMHO are firmly at the hamburger end of "taste"

Another thing for 2.5 is going to be to weed out the unused and unmaintained
drivers, and either someone fixes them or they go down the comsic toilet and
we pull the flush handle before 2.6 comes out.

Thankfully the scsi layer breakage is going to help no end in the area of 
clockwork 8 bit scsi controllers, which is major culprit number 1. number 2
is probably the audio which is hopefully going to go away with ALSA based
code.

Alan
