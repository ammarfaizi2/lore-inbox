Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbTIPXMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTIPXMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:12:52 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:20866
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262550AbTIPXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:12:49 -0400
Date: Tue, 16 Sep 2003 19:12:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another keyboard woes with 2.6.0...
In-Reply-To: <Pine.LNX.4.53.0309161844380.23370@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0309161911160.23370@montezuma.fsmlabs.com>
References: <20030912165044.GA14440@vana.vc.cvut.cz>
 <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com>
 <20030916232318.A1699@pclin040.win.tue.nl> <Pine.LNX.4.53.0309161844380.23370@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Zwane Mwaikambo wrote:

> On Tue, 16 Sep 2003, Andries Brouwer wrote:
> 
> > In Petr's case it looks like his switch produces a single well-defined
> > byte (0x41) when switching. What about you? Do you get garbage at the
> > moment of switching, or always the same code(s)?
> > Do you only get the spurious repeat when switching?
> > Andrew gets spurious repeats together with mouse activity. Do you?

Nope mouse activity doesn't seem to do it

> > I am especially interested in cases where people can reproduce
> > an unwanted key repeat. The question is: is this a bug in our timer code
> > or use of timers, or did the keyboard never send the key release code?
> > 
> > (#define DEBUG in i8042.c)
> 
> Hi Andries, sorry for not following up. i'll enable and test this 
> immediately, my case is a bit hard to reproduce (a matter of days) but if 
> you'd like to see a capture from KVM switching i can do that.
> 
> Follow up coming shortly...

Here is an excerpt from a KVM switch, ls -l, KVM switch;

drivers/input/serio/i8042.c: 26 <- i8042 (interrupt, kbd, 1) [150578]
drivers/input/serio/i8042.c: 1f <- i8042 (interrupt, kbd, 1) [150654]
drivers/input/serio/i8042.c: a6 <- i8042 (interrupt, kbd, 1) [150683]
drivers/input/serio/i8042.c: 39 <- i8042 (interrupt, kbd, 1) [150713]
drivers/input/serio/i8042.c: 9f <- i8042 (interrupt, kbd, 1) [150758]
drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, kbd, 1) [150789]
drivers/input/serio/i8042.c: b9 <- i8042 (interrupt, kbd, 1) [150853]
drivers/input/serio/i8042.c: 26 <- i8042 (interrupt, kbd, 1) [150884]
drivers/input/serio/i8042.c: 8c <- i8042 (interrupt, kbd, 1) [150931]
drivers/input/serio/i8042.c: a6 <- i8042 (interrupt, kbd, 1) [150986]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, kbd, 1) [151090]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, kbd, 1) [151208]
drivers/input/serio/i8042.c: 1d <- i8042 (interrupt, kbd, 1) [152374]
drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, kbd, 1) [152439]
drivers/input/serio/i8042.c: 1d <- i8042 (interrupt, kbd, 1) [152653]
drivers/input/serio/i8042.c: 9d <- i8042 (interrupt, kbd, 1) [152708]

Need something more specific?
