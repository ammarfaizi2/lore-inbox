Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUCBW0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUCBW0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:26:09 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:37729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262098AbUCBW0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:26:03 -0500
Date: Tue, 2 Mar 2004 23:25:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] Re: README update
Message-ID: <20040302222552.GC1225@elf.ucw.cz>
References: <20040301194222.GA9491@elf.ucw.cz> <200403021116.37273.amitkale@emsyssoft.com> <20040302151704.GD16434@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302151704.GD16434@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Index: README
> > > ===================================================================
> > > RCS file: /cvsroot/kgdb/kgdb-2/README,v
> > > retrieving revision 1.3
> > > diff -u -u -r1.3 README
> > > --- README	22 Feb 2004 14:14:05 -0000	1.3
> > > +++ README	1 Mar 2004 19:34:38 -0000
> > > @@ -37,15 +37,17 @@
> > >  Boot:
> > >  -----
> > >  Supply command line options kgdbwait and kgdb8250 to the kernel.
> > > -Example:  kgdbwait kgdb8250=1,115200
> > > -
> > > +Example:  kgdbwait kgdb8250=0,115200
> > > +(for ttyS0), then
> > > +   % stty 115200 < /dev/ttyS0
> > > +   % gdb ./vmlinux
> > > +   (gdb) target remote /dev/ttyS0
> 
> % gdb ./vmlinux
> (gdb) set remotebaud 115200
> (gdb) target remote /dev/ttyS0
> 
> ?

Yep, that's probably better. If nobody complains, I'll commit it
tommorow.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
