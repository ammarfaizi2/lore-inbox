Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUGTO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUGTO0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUGTOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:25:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54921 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265960AbUGTOYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:24:08 -0400
Date: Tue, 20 Jul 2004 16:24:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org
Subject: Re: [12/25] Merge pmdisk and swsusp
Message-ID: <20040720142404.GA4724@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171529530.22290-100000@monsoon.he.net> <20040718221653.GD31958@atrey.karlin.mff.cuni.cz> <20040720122141.GH1651@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720122141.GH1651@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +static void wait_io(void)
> > > +{
> > > +	while(atomic_read(&io_done))
> > > +		io_schedule();
> > > +}
> > ...
> > > +	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
> > > +	wait_io();
> > > + Done:
> > > +	bio_put(bio);
> > > +	return error;
> > > +}
> > 
> > Perhaps it is worth it to inline wait_io?
> 
> Since it's not a fast path, does it matter?

It does not, just if you inline wait_io inside bigger function, it
gets 4 line shorter...
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
