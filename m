Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282453AbRK0Sai>; Tue, 27 Nov 2001 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281322AbRK0SaT>; Tue, 27 Nov 2001 13:30:19 -0500
Received: from [209.249.147.248] ([209.249.147.248]:15122 "EHLO
	proxy1.addr.com") by vger.kernel.org with ESMTP id <S281221AbRK0SaQ>;
	Tue, 27 Nov 2001 13:30:16 -0500
Date: Tue, 27 Nov 2001 13:26:15 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: Pavel Machek <pavel@suse.cz>
Cc: jsimmons@transvirtual.com, mj@ucw.cz, linux-kernel@vger.kernel.org,
        acpi@phobos.fachschaften.tu-muenchen.de
Subject: Re: Restoring videomode on return from S3 sleep
Message-Id: <20011127132615.0a25c838.dang@fprintf.net>
In-Reply-To: <20011127191604.A3152@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011126210621.A2039@elf.ucw.cz>
	<Pine.LNX.4.10.10111271003070.21131-100000@www.transvirtual.com>
	<20011127191604.A3152@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 19:16:04 +0100
Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > > I'll need to restore video mode on returning from acpi sleep...
> > > 
> > > Unfortunately, video selection code is not part of kernel, it is
> > > 16-bit code. acpi_wakeup.S, otoh, *is* part of kernel :-(. 
> > 
> > Is this on the console and if it is I assum you are uing vgacon. It could 
> > be the S# card has a broken implemenation. This wouldn't be the first.
> > Their has been a patch sometime for vesafb to work properly with S3 cards.
> > 
> > S3 framebuffer anyone? I remember their has been scathered work on this
> > but I never seen anything come to light for this.
> 
> Oh. Sorry. By S3 I mean ACPI S3 state. ACPI S3 == suspend to RAM.
> 
> Basically what I need is to restore video mode after returning from
> ACPI S3 sleep state, so that vesafb works properly.
> 								Pavel

I need the same for APM. (I would prefer ACPI, but it currently hangs by box) 
I have to use vesafb or I get artifacts (Trident CyberBlade/XP), but then a
resume from APM never restores the video.  Presumably, a reset (similar to
when the fb is turned on?) would fix the problem.  I haven't looked into it
yet due to lack of time, but if someone else is going to work on it, I'll
gladly help test.

Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

