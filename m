Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSATUSh>; Sun, 20 Jan 2002 15:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSATUS2>; Sun, 20 Jan 2002 15:18:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:3849 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283003AbSATUSO>;
	Sun, 20 Jan 2002 15:18:14 -0500
Subject: Re: Preempt & how long it takes to interrupt (was Re:
	[2.4.17/18pre] VM and swap - it's really unusable)
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020118224140.GI6918@elf.ucw.cz>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com>
	<20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there>
	<3C42CA59.F070C2B8@aitel.hist.no>  <20020118224140.GI6918@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 20 Jan 2002 15:22:16 -0500
Message-Id: <1011558138.8596.317.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-18 at 17:41, Pavel Machek wrote:

> So... how long do you have to stay in interrupt for it to be a bug?
> 
> There's *no* requirement that says "it may not take second to handle
> an interrupt". Actually I guess that some nasty conditions (UHCI needs
> reset?) may take that long in interrupt. Oh and actually few releases
> ago, console switching was done from interrupt and it *did* take 2
> seconds for me.
> 
> If someone assumes interrupts are "short", he has broken code already.

Agreed.  Conversely, however, writing code that introduces long
interrupt-off periods should be considered a BUG.

In other words, relying on short interrupt-off periods is bad form, but
so is writing gross code that rudely keeps them off.

I think we all considered the long off periods in VT switching and fbdev
a bug.

	Robert Love

