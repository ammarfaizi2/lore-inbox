Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263019AbTC1Po4>; Fri, 28 Mar 2003 10:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbTC1Po4>; Fri, 28 Mar 2003 10:44:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263019AbTC1Poy>;
	Fri, 28 Mar 2003 10:44:54 -0500
Date: Fri, 28 Mar 2003 08:58:03 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Swsusp <swsusp@lister.fornax.hu>, Florent Chabaud <fchabaud@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Annouce: Initial SWSUSP 2.4 port to 2.5 available.
In-Reply-To: <20030328113549.GB10121@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0303280857540.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Mar 2003, Pavel Machek wrote:

> Hi!
> 
> > I'm glad to hear that you have completed the full port, but many people 
> > appreciate incremental patches, especially if the cumulative changes 
> > touch multiple parts of the kernel. Please consider breaking the one large 
> > patch into multiple, easily digestible, chunks. 
> > 
> > Finally, with either patch, there are unresolved symbols:
> > 
> > arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
> > arch/i386/kernel/built-in.o(.data+0x1644): undefined reference to `save_processor_state'
> > arch/i386/kernel/built-in.o(.data+0x164a): undefined reference to `saved_context_esp'
> > arch/i386/kernel/built-in.o(.data+0x164f): undefined reference to `saved_context_eax'
> > arch/i386/kernel/built-in.o(.data+0x1655): undefined reference to `saved_context_ebx'
> > arch/i386/kernel/built-in.o(.data+0x165b): undefined reference to `saved_context_ecx'
> > arch/i386/kernel/built-in.o(.data+0x1661): undefined reference to `saved_context_edx'
> > arch/i386/kernel/built-in.o(.data+0x1667): undefined reference to `saved_context_ebp'
> > arch/i386/kernel/built-in.o(.data+0x166d): undefined reference to `saved_context_esi'
> > arch/i386/kernel/built-in.o(.data+0x1673): undefined reference to `saved_context_edi'
> > arch/i386/kernel/built-in.o(.data+0x167a): undefined reference to `saved_context_eflags'
> > 
> > The fix is likely trivial, but it is annoying that it happens in the first 
> > place.
> 
> Thats S3 support. Likely Nigel has not S3 compiled in and you
> have. Disalbe CONFIG_ACPI_SLEEP as a workaround.

That works.

Thanks,


	-pat

