Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSAORu2>; Tue, 15 Jan 2002 12:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290213AbSAORuO>; Tue, 15 Jan 2002 12:50:14 -0500
Received: from air-1.osdl.org ([65.201.151.5]:50568 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290214AbSAORtO>;
	Tue, 15 Jan 2002 12:49:14 -0500
Date: Tue, 15 Jan 2002 09:50:55 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
In-Reply-To: <20020115025530.A11314@suse.de>
Message-ID: <Pine.LNX.4.33.0201150941130.827-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What do people think about the concept?
>
> Well, it chops out a load of ugly ifdefs, and makes adding support
> for a new bus less intrusive than it currently is. I quite like it.

Cool. I'll change the other buses in init/main.c and post it.

> > I will warn that the name is kinda clumsy, but it's the best that I could
> > come up with (I wasted my creativity for the day on thinking about
> > Penelope). I used "subsystem" because I have alterior motives.
>
> I think you hit the nail on the head with the subject line.
> struct BusDriver also conjures up amusing[*] imagery.

Yes, next I'll be adding a common set of routines for BusDrivers,
including drive(), stop(), give_people_dirty_looks(), and swerve()...

> One thing I'm wondering about though. Is it possible for a new
> bus to be added after boot ? Docking stations etc show up as
> children on the root PCI bus, so that shouldn't be an issue.

A new bus? Sure, the bus driver just has to probe behind it.

USB can do it. The PCI probe routines are all declared __devinit, so if
you have hotplug support, you should be able to do it in theory. Greg?

> Ah! hotplug PCI USB controller ?

Cardbus, Hotplug PCI, docking stations..

	-pat

