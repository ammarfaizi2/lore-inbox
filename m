Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVBDGeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVBDGeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVBDGeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:34:09 -0500
Received: from fsmlabs.com ([168.103.115.128]:62880 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261819AbVBDGeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:34:03 -0500
Date: Thu, 3 Feb 2005 23:33:29 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
In-Reply-To: <20050204051929.GO14325@atomide.com>
Message-ID: <Pine.LNX.4.61.0502032329150.26742@montezuma.fsmlabs.com>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz>
 <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz>
 <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz>
 <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz>
 <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Tony Lindgren wrote:

> > > > It could also be that the reprogamming of PIT timer does not work on
> > > > your machine. I chopped off the udelays there... Can you try
> > > > something like this:
> > > 
> > > I added the udelays, but behaviour did not change.
> > 
> > Yeah, and if the first patch was working better, that means the PIT
> > interrupts work. I'll do another version of the patch where PIT
> > interrupts work again without local APIC needed, let's see what
> > happens with that.

I see in the patch that you're reprogramming the PIT for a periodic mode 
(2) but using dyn_tick->skip as the period. Is this intentional? I thought 
you wanted a oneshot for that.
