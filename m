Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbTC1LYi>; Fri, 28 Mar 2003 06:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262931AbTC1LYi>; Fri, 28 Mar 2003 06:24:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62729 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262914AbTC1LYh>; Fri, 28 Mar 2003 06:24:37 -0500
Date: Fri, 28 Mar 2003 12:35:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Swsusp <swsusp@lister.fornax.hu>, Florent Chabaud <fchabaud@free.fr>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Annouce: Initial SWSUSP 2.4 port to 2.5 available.
Message-ID: <20030328113549.GB10121@atrey.karlin.mff.cuni.cz>
References: <1048732097.1731.14.camel@laptop-linux.cunninghams> <Pine.LNX.4.33.0303271051350.1001-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303271051350.1001-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm glad to hear that you have completed the full port, but many people 
> appreciate incremental patches, especially if the cumulative changes 
> touch multiple parts of the kernel. Please consider breaking the one large 
> patch into multiple, easily digestible, chunks. 
> 
> Finally, with either patch, there are unresolved symbols:
> 
> arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
> arch/i386/kernel/built-in.o(.data+0x1644): undefined reference to `save_processor_state'
> arch/i386/kernel/built-in.o(.data+0x164a): undefined reference to `saved_context_esp'
> arch/i386/kernel/built-in.o(.data+0x164f): undefined reference to `saved_context_eax'
> arch/i386/kernel/built-in.o(.data+0x1655): undefined reference to `saved_context_ebx'
> arch/i386/kernel/built-in.o(.data+0x165b): undefined reference to `saved_context_ecx'
> arch/i386/kernel/built-in.o(.data+0x1661): undefined reference to `saved_context_edx'
> arch/i386/kernel/built-in.o(.data+0x1667): undefined reference to `saved_context_ebp'
> arch/i386/kernel/built-in.o(.data+0x166d): undefined reference to `saved_context_esi'
> arch/i386/kernel/built-in.o(.data+0x1673): undefined reference to `saved_context_edi'
> arch/i386/kernel/built-in.o(.data+0x167a): undefined reference to `saved_context_eflags'
> 
> The fix is likely trivial, but it is annoying that it happens in the first 
> place.

Thats S3 support. Likely Nigel has not S3 compiled in and you
have. Disalbe CONFIG_ACPI_SLEEP as a workaround.
							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
