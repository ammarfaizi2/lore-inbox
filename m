Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbTL0K3e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 05:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbTL0K3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 05:29:34 -0500
Received: from gprs214-84.eurotel.cz ([160.218.214.84]:31617 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265350AbTL0K3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 05:29:32 -0500
Date: Sat, 27 Dec 2003 11:30:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kgdb without serial port
Message-ID: <20031227103030.GG197@elf.ucw.cz>
References: <20031215200640.GA3724@elf.ucw.cz> <20031215223438.196295a8.akpm@osdl.org> <20031226182740.GA10397@elf.ucw.cz> <20031226110851.29ce9fa5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226110851.29ce9fa5.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
> > > > but still require me to fill in serial port interrupt/address. Is
> > > > there easy way to make it work without serial port? [This notebook has
> > > > none :-(].
> > > 
> > > That's a bit ugly, but things should still work OK?  Give it some random
> > > UART address but specify an ethernet connection at boot time - the kgdb
> > > stub should never touch the UART.
> > 
> > I found out what was biting me: using 2.95 with kgdb is bad idea. 2.95
> > with kgdb means reboot just after uncompressing kernel -- pretty nasty
> > to debug. Please apply,
> 
> I've been using 2.95.3 on and off for ages, no problems?

Strange... Okay, some details. If I use gcc-2.95.4 (from debian) by
setting GCC = gcc-2.95, it crashes very early during boot. So perhaps
it dislikes "crosscompiling" instead of specific gcc version? [I was
doing that to speed compiles up].
								Pavel		

> Spose so.  The kgdb stub really needs a serious reorganisation so that
> non-ia32 architectures can share generic things.  And general reduction of
> the patch footprint, maybe some feature removal too.   A fairly large job.

Yes, and as I need kgdb on x86-64...

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
