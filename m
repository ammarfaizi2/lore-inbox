Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCRT4e>; Mon, 18 Mar 2002 14:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCRT4Z>; Mon, 18 Mar 2002 14:56:25 -0500
Received: from [195.39.17.254] ([195.39.17.254]:34946 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292594AbSCRT4O>;
	Mon, 18 Mar 2002 14:56:14 -0500
Date: Mon, 18 Mar 2002 20:21:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020318192136.GC194@elf.ucw.cz>
In-Reply-To: <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E28A1.1070902@evision-ventures.com> <20020312172134.A5026@ucw.cz> <3C8E2C2C.2080202@evision-ventures.com> <20020312173301.C5026@ucw.cz> <3C8E3025.4070409@evision-ventures.com> <20020312175044.A5228@ucw.cz> <20020314140210.A37@toy.ucw.cz> <20020315121352.A25209@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You may happen to have the numbers, though - that should be enough.
> > > 
> > > Btw, I have a CMD640B based PCI card lying around here, but never
> > > managed to get it generate any interrupts, though the rest seems to be
> > > working.
> > 
> > Attach it to the timer interrupt -- that should do it for testing. Simplest
> > way is to make ide timeouts HZ/100 and killing "lost interrupt" msg ;-).
> 
> Well, it seems like we'll have to something like this anyway. Some chips
> sometimes forget to assert the IRQ after a transfer due to HW bugs, and
> some PIIX3s are reported to do it quite often.

What is "quite often"? Unless it is more than once in a hour, current
code is just okay... (It waits for timeout, which is about 30 sec?,
then recovers).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
