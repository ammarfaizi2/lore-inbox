Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUGTTYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUGTTYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUGTTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:23:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48039 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266158AbUGTTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:21:25 -0400
Date: Tue, 20 Jul 2004 21:21:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040720192123.GA9461@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net> <20040720164640.GH10921@atrey.karlin.mff.cuni.cz> <20040720192858.GB9147@mars.ravnborg.org> <200407201241.52334.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407201241.52334.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > diff -ur linux.middle/kernel/power/disk.c linux/kernel/power/disk.c
> > > --- linux.middle/kernel/power/disk.c	2004-07-19 08:58:08.000000000 -0700
> > > +++ linux/kernel/power/disk.c	2004-07-19 15:00:16.000000000 -0700
> > > @@ -63,6 +63,9 @@
> > >  		break;
> > >  	}
> > >  	machine_halt();
> > > +	/* Valid image is on the disk, if we continue we risk serious data corruption
> > > +	   after resume. */
> > > +	while(1);
> > 
> > Would be nicer to use:
> > 
> > 	while(1)
> > 		/* Loop forever */;
> > 
> > 	Sam
> 
> And even nicer would be remove swsusp signature from swap and restore state as
> original version did so user could do clean shutdown...

Actually, at this point you are expected to just power down, and what
you wanted is done: machine is suspended to disk.

No need to kill signature and make swsusp unusable when powerdown does
not work.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
