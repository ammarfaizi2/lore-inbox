Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312193AbSC2Vw2>; Fri, 29 Mar 2002 16:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSC2VwR>; Fri, 29 Mar 2002 16:52:17 -0500
Received: from air-2.osdl.org ([65.201.151.6]:30867 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S312169AbSC2VwG>;
	Fri, 29 Mar 2002 16:52:06 -0500
Date: Fri, 29 Mar 2002 13:50:06 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: [patch] Device model update (with power state transitions)
In-Reply-To: <20020329212745.GA4751@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0203291348040.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Mar 2002, Pavel Machek wrote:

> Hi!
> 
> > (The first is not necessarily related to the other two, but the other two 
> > were created relative to the first, and it's otherwise innocuous).
> > 
> > 1. Implements notion of 'system' bus, so system level devices can be added 
> > in a comon spot. This includes things like CPUs, PICs, timers, etc.
> 
> Good thing, but naming is pretty inconsistent.
> 
> You have device_register() but register_sys_device(). 

Noted. How about sys_device_register()?

> > Testing welcome also, though I wouldn't expect one to get very far, since 
> > they're not actually used. ;) Which, brings up another question - what 
> > would be the proper place to call device_shutdown()? (I haven't looked 
> > very far into that part...)
> 
> Tested, seems to work.
> 									Pavel
> PS: On toshiba 4030cdt, I can suspend once without no apparent ill
> effects. On resume I get 
> 
> utmisc-0373 Ut_acquire_mutex : Invalid acquire order: Thread 5C owns
> [ACPI_MTX_Hardware], wants [ACPI_MTX_Namespace].
> 
> followed by more warnings. Is there easy way to debug this?

Maybe using one of the kernel debuggers? I haven't ever used one, but it 
sounds like you should have enough context where it would work..

	-pat

