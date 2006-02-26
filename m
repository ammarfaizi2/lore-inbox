Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWBZX4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWBZX4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWBZX4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:56:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60297 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751427AbWBZX4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:56:30 -0500
Date: Mon, 27 Feb 2006 00:56:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: improve memory shrinking
Message-ID: <20060226235614.GE2396@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060226185319.GB2055@elf.ucw.cz> <200602270032.25324.rjw@sisk.pl> <200602270038.41287.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602270038.41287.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 27-02-06 00:38:40, Rafael J. Wysocki wrote:
> On Monday 27 February 2006 00:32, Rafael J. Wysocki wrote:
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
> ... and this is the workaround of the "shrink_all_memory() returns 0 prematurely"
> problem (not tested separately yet).  [Together these patches make my box
> actually free more memory when image_size = 0.]

He he, move the workaround into mm/vmscan.c to get Andrew's attetion
then attempt to push it :-))). That way

1) shrink_all_memory() will get fixed for all callers

2) you'll probably force akpm to fix it the right way :-).

								Pavel

-- 
Feeling evil tonight.
