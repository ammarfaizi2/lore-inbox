Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWB0AON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWB0AON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWB0AON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:14:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:54697 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751449AbWB0AOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:14:12 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Date: Mon, 27 Feb 2006 01:06:12 +0100
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602270032.25324.rjw@sisk.pl> <20060226235227.GD2396@elf.ucw.cz>
In-Reply-To: <20060226235227.GD2396@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602270106.12464.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 27 February 2006 00:52, Pavel Machek wrote:
> On Po 27-02-06 00:32:24, Rafael J. Wysocki wrote:
> > On Sunday 26 February 2006 19:53, Pavel Machek wrote:
> > > > > > > I did try shrink_all_memory() five times, with .5 second delay between
> > > > > > > them, and it freed more memory at later tries.
> > > > > > 
> > > > > > I wonder if the delays are essential or if so, whether they may be shorter
> > > > > > than .5 sec.
> > > > > 
> > > > > I was using this with some success... (Warning, against old
> > > > > kernel). But, as I said, I consider it ugly, and it would be better to
> > > > > fix shrink_all_memory.
> > > > 
> > > > Appended is a patch against the current -mm.
> > > >   [It also makes
> > > > swsusp_shrink_memory() behave as documented for image_size = 0.
> > > > Currently, if it states there's enough free RAM to suspend, it won't bother
> > > > to free a single page.]
> > > 
> > > Could we get bugfix part separately?
> > 
> > Sure.  Appended is the bugfix (I haven't tested it separately yet, but I think
> > it's simple enough) ...
> 
> Are you sure? The way I read old code ... it looks correct to me.
> 
> size is always > 1000 or so. if image_size = 0, size >
> image_size/PAGE_SIZE and we'll loop as long as shrink_all_memory()
> frees something.

Of course, you are right.

So the original patch was what's needed to get the workaround in. :-)

Greetings,
Rafael

