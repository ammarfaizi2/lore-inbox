Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSKLNXl>; Tue, 12 Nov 2002 08:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbSKLNXl>; Tue, 12 Nov 2002 08:23:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:4315 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266555AbSKLNXl>;
	Tue, 12 Nov 2002 08:23:41 -0500
Date: Tue, 12 Nov 2002 08:30:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rando Christensen <rando@babblica.net>
cc: Dave Jones <davej@codemonkey.org.uk>, spyro@f2s.com, xavier.bestel@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: devfs
In-Reply-To: <20021112042408.02d2e3e3.rando@babblica.net>
Message-ID: <Pine.GSO.4.21.0211120807430.3700-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Nov 2002, Rando Christensen wrote:

> Rather than saying "Devfs sucks, and we can't do anything about it other
> than fix it's more minor problems because we're in feature freeze", we
> should be saying "devfs sucks; we're a little late for feature freeze,
> so let's clean up what we can and work on something much better for the
> next time around."

Whatever is going to happen with devfs, believe me, the first thing
you'll need is stable glue in drivers - as simple and natural from the
driver POV as possible.  Complexity of doing development in 2.6 will
directly depend on the amount of code in drivers touched by patches.
BTDT - one can carry (and gradually merge) deep rewrites of core code
during -STABLE if it's done carefully.  But as soon as your patchset
hits the drivers - you are in for a world of pain just porting it to
next versions.

_That_ is critical - get interfaces right in -CURRENT, so that further
work would not cross these boundaries; then work in the resulting areas
becomes independent.  

And in situations like that of devfs, simple rules for callers are pretty
much the main criteria - if users of the interface have to jump through
some hoops, it's a sign that interface needs changes...

