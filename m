Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVF2GlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVF2GlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVF2GlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:41:19 -0400
Received: from mail1.kontent.de ([81.88.34.36]:47567 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262209AbVF2GlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:41:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Mike Bell <kernel@mikebell.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Wed, 29 Jun 2005 08:41:29 +0200
User-Agent: KMail/1.8
References: <20050624081808.GA26174@kroah.com> <200506281400.08777.oliver@neukum.org> <20050628200824.GA12851@kroah.com>
In-Reply-To: <20050628200824.GA12851@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506290841.29785.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. Juni 2005 22:08 schrieben Sie:
> On Tue, Jun 28, 2005 at 02:00:08PM +0200, Oliver Neukum wrote:
> > Am Dienstag, 28. Juni 2005 09:40 schrieb Greg KH:
> > > On Mon, Jun 27, 2005 at 04:26:00PM -0700, Mike Bell wrote:
> > > > On Mon, Jun 27, 2005 at 05:35:50PM -0500, Dmitry Torokhov wrote:
> > > > > AFAIK there is no requirement in input subsystem that devices should be
> > > > > created under /dev/input. When devfs is activated they are created there
> > > > > by default, but that's it.
> > > > 
> > > > Things which accept a path to an event file as an argument will work
> > > > just fine. But anything which tries autodiscovery HAS to be able to find
> > > > the device nodes. Think directfb, most (but not all) of the X patches,
> > > > any user-space driver that wants to find the hardware it owns, etc.
> > > > 
> > > > This illustrates nicely my reasons for preferring devfs.
> > > > 
> > > > 1) Predictable, canonical device names are a Good Thing.
> > > 
> > > And impossible for the kernel to generate given hotpluggable devices.
> > 
> > That is not true. The kernel can generate predictable device names.
> > It just cannot generate _stable_ device names under all circumstances.
> 
> Well, I view "canonical" as, "this is the name for this specific device,
> and will always be that name".  But, if others think of it differently,
> hey, that's fine with me too.

Isn't the canonical way to use canonical to mean a name that is independent
of a particular system but set in a standard? Such a name could be generated
only if the device itself is unique. Short of network cards and
bluetooth devices you'll be short on canonical, stable names.

In other cases you have heuristics and system configuration. These are nice
to have, but have limits and problems. Firstly, they are heuristics and thus
a bit risky to use. Secondly, they sometimes need system configuration.
And this very much limits usefullness to embedded and indeed single user
systems.

What devfs and udev can do, and a static dev cannot, is names independent
of order of detection. As for ressources, it is an illusion to think that user
space means less ressources. A demon means page tables and a kernel
stack. That 12K unswappable memory in the best case.

	Regards
		Oliver
