Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135762AbRDTAMf>; Thu, 19 Apr 2001 20:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRDTAMP>; Thu, 19 Apr 2001 20:12:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16400 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135762AbRDTAME>; Thu, 19 Apr 2001 20:12:04 -0400
Date: Thu, 19 Apr 2001 17:11:32 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-pm-devel@lists.sourceforge.net
Subject: Re: [Linux-pm-devel] Re: PCI power management
In-Reply-To: <3ADEE701.F3726B5B@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10104191708260.7690-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  - On SMP, we need some way to stop other CPUs in the scheduler
> > while running the last round of sleep (putting devices to sleep) at least
> > until all IO layers in Linux can properly handle blocking of IO queues
> > while the device sleeps.
> 
> I think either Rusty or Anton wrote code to enable and disable CPUs...
> 
> CPU hotplugging but it would be useful for PM too.

There's more than that, too. The ACPI spec says that the system must be
able to handle complete dynamic reconfiguration of the system during
suspend/resume. Basically an ideal solution would assume that any device
could have been added or removed while the system was asleep, so it must
account for it by initializing the device and allocating system resources.

Granted CPU hotplugging is a different ballpark, but it's the same league.

	-pat

