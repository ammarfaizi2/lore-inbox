Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUEBPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUEBPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEBPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 11:55:09 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6644 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263121AbUEBPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 11:55:05 -0400
Date: Sun, 2 May 2004 11:55:07 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH][2.4] remove amd7(saucy)_tco
In-Reply-To: <20040502084841.GA10228@alpha.home.local>
Message-ID: <Pine.LNX.4.58.0405021151400.2332@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405011534230.2332@montezuma.fsmlabs.com>
 <20040502084841.GA10228@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004, Willy Tarreau wrote:

> On Sat, May 01, 2004 at 03:37:36PM -0400, Zwane Mwaikambo wrote:
> > Hello Marcelo,
> > 	This driver has already been removed in 2.6, essentially we've had
> > problems getting it working (it's been a while now) with a lot of boards,
> > all seems to be alright until the actual point where the hardware is
> > supposed to reset the system. So lets just back it out.
>
> Indeed, I've just checked here, because I believed I had seen it working,
> but now I think it was the softdog. It does nothing at all. I've downloaded
> and read AMD's datasheet and the driver seems to do the right thing. BTW,
> I wonder if the chip is buggy or not, because I tried to play with the
> SYSRST and FULLRST bits in the 0xCF9 register. Changing SYSRST to 1 does not
> change anything, and changing FULLRST to 1 immediately reboots the machine
> even if no reset was pending !

That agrees with what Martin Josefsson and i came across, we ended up
combing through the datasheet and ended up coming to the conclusion that
either we were missing something subtle or the hardware just didn't work.
It's a shame because i had a friend who had a whole bunch of these and
wanted to use the watchdog in production.

	Zwane
