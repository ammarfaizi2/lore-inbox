Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSGBVsN>; Tue, 2 Jul 2002 17:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSGBVsM>; Tue, 2 Jul 2002 17:48:12 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:46066
	"EHLO mythical") by vger.kernel.org with ESMTP id <S312590AbSGBVsM>;
	Tue, 2 Jul 2002 17:48:12 -0400
Date: Tue, 2 Jul 2002 17:50:19 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: Oliver Neukum <oliver@neukum.name>
cc: Tom Rini <trini@kernel.crashing.org>, Jonathan Corbet <corbet@lwn.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
In-Reply-To: <200207022010.50572.oliver@neukum.name>
Message-ID: <Pine.LNX.4.10.10207021746570.579-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Oliver Neukum wrote:

> Am Dienstag, 2. Juli 2002 19:48 schrieb Tom Rini:
> > On Tue, Jul 02, 2002 at 06:07:06PM +0200, Oliver Neukum wrote:
> > > > developing drivers and such.  Aunt Tillie would no longer be able to
> > > > remove modules from her kernel, but that's not likely to bother her
> > > > too much...
> > >
> > > It would very much bother uncle John, who is in high availability.
> >
> > Then the HA kernel turns on the ability to still remove modules, along
> > with all of the other things needed in an HA environment but not
> > elsewhere.  Provided removing a module doesn't become a horribly racy,
> > barely usable bit of functionality, which I hope it won't.
> 
> Either there is a race or there isn't. Such a thing is unusable on a
> production system.

In a single processor, no preempt kernel, there is no race.
Turn on SMP or preempt and there is one.

Anyway, on a HA machine, how the heck are you going to be removing
modules anyway?  If one of your two identical network cards fails, you
lose your HA status if you need to shut down both to remove the module
and thus be able to remove the second card, right?

I would think the HA guys would be pushing for a status of "modules are
never removed, so design around that" to make their lives easier.  That
would also mean you would have a way to say, "hey driver, rescan for
devices - I think you'll find a new one that you should manage".


--
Ryan Anderson
  sometimes Pug Majere

