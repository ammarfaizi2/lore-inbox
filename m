Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSBMXCt>; Wed, 13 Feb 2002 18:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSBMXC3>; Wed, 13 Feb 2002 18:02:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57095 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289058AbSBMXCT>; Wed, 13 Feb 2002 18:02:19 -0500
Date: Wed, 13 Feb 2002 18:00:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16b1nb-0001p5-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020213175335.12448I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Daniel Phillips wrote:

> > A module can get displaced as easily as a plain text file, and the wrong
> > "configutarion module" version won't do any good in any case.
> 
> Not necessarily, check out the work on bootfs, I think this can be adapted to
> suit the purpose.  If the config is in a module then we'd normally want that
> module to be one of the modules that is included in the boot image.

It should not be in the boot image, or at least it should be usable
elsewhere, because it isn't used at boot. It is only used in a running
system (not necessarily booted from the kernel in question, but running as
opposed to needed by lilo/grub).

> There is no good way to know where you have put those things.  We're looking
> for a tight coupling between the kernel image and metadata that describes
> what's in it - like a label on an electronic component: stuck right on it,
> not filed away in a filing cabinet.

But that tight coupling has a cost, and the reason for compressed kernel
is to make it small to fit {places}, which is one of the benefits of
modules. Putting it in the kernel or nowhere is not optimal, most people
can manage to find documentation which isn't bound that tightly. If it's
available as a module it's useful in all the ways people currently use
things they may or may not want in the kernel, even if "in the kernel"
only means "stuck to the boot image."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

