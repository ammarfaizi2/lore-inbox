Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSG3Xo3>; Tue, 30 Jul 2002 19:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSG3Xo3>; Tue, 30 Jul 2002 19:44:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16646 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317424AbSG3Xo2>;
	Tue, 30 Jul 2002 19:44:28 -0400
Date: Tue, 30 Jul 2002 16:46:31 -0700
From: Greg KH <greg@kroah.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020730234630.GA17979@kroah.com>
References: <20020730225359.GA17826@kroah.com> <200207302312.g6UNC7Z10529@vindaloo.ras.ucalgary.ca> <20020730231841.GA17955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730231841.GA17955@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 22:24:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 04:18:41PM -0700, Greg KH wrote:
> On Tue, Jul 30, 2002 at 05:12:07PM -0600, Richard Gooch wrote:
> > 
> > Your patch misses the reason why I created those functions: some
> > drivers had to always register with the major table. With your
> > "fixups", those drivers will break when "devfs=only" is passed in. If
> > you first fix the drivers so that they work without an entry in the
> > major table, then your patch is safe to apply.
> 
> Ah, then this "feature" should be written down somewhere.  Which drivers
> does this happen for?  And why penalize _all_ of the kernel drivers for
> only the few that need this?

Actually, in reading through the devfs documentation some more about the
"devfs=only" option, I think this patch should be accepted.  Just
because you have not fixed up some remaining drivers for the (to quote
you) "dedicated souls" who want to use this option.

Don't force such a large and intrusive API change into loads of drivers
that do not want anything to do with devfs, just because your feature is
not yet complete.

If nothing else, it would force you (or people who actually use
"devfs=only") to fix those remaining drivers, which I would expect you
to view as a good thing :)

thanks,

greg k-h
