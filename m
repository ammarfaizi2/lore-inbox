Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSATTZJ>; Sun, 20 Jan 2002 14:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSATTZA>; Sun, 20 Jan 2002 14:25:00 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:8374 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288951AbSATTYy>; Sun, 20 Jan 2002 14:24:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Pavel Machek <pavel@suse.cz>, Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Preempt & how long it takes to interrupt (was Re: [2.4.17/18pre] VM and swap - it's really unusable)
Date: Sun, 20 Jan 2002 06:22:47 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <3C42CA59.F070C2B8@aitel.hist.no> <20020118224140.GI6918@elf.ucw.cz>
In-Reply-To: <20020118224140.GI6918@elf.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120192453.GVRA23469.femail45.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 05:41 pm, Pavel Machek wrote:

> So... how long do you have to stay in interrupt for it to be a bug?
>
> There's *no* requirement that says "it may not take second to handle
> an interrupt". Actually I guess that some nasty conditions (UHCI needs
> reset?) may take that long in interrupt. Oh and actually few releases
> ago, console switching was done from interrupt and it *did* take 2
> seconds for me.
>
> If someone assumes interrupts are "short", he has broken code already.

That kinda defeats the entire purpose of low-latency patches, doesn't it?

I'm not entirely certain what Alan's smoking if he's raising the straw man 
argument of a two second delay dropping 300 packets and causing connections 
to abort (my sister's on DSL, 5 second dropouts every time the phone rings, 
but connections continue just fine.  Wouldn't want to play quake under those 
circumstances, but would I really have the ~200 CPU-hog background threads 
while playing quake as per Alan's example, and even then the argument is just 
that either the network driver or the network card is bad...)

Still not as bad an example as Aunt Tillie, I'll grant you...

Rob
