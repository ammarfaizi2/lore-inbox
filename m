Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbTCGXr0>; Fri, 7 Mar 2003 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbTCGXqz>; Fri, 7 Mar 2003 18:46:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:25100 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261891AbTCGXpG>;
	Fri, 7 Mar 2003 18:45:06 -0500
Date: Fri, 7 Mar 2003 15:45:41 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: hch@infradead.org, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030307234541.GG21315@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307143319.2413d1df.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 02:33:19PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> > > 
> > > 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> > > stream.  Can we put this ahead of cleanup stuff?
> > 
> > Can we get people to agree that this will even go into 2.5, due to the
> > lateness of it?  I didn't think it was going to happen.
> 
> I've never seen the patches so I cannot say.  But I'd at least like to get
> the whole thing under test so we can make that evaulation.

I would too.  Andries's patches look like the right thing to do, so far
as I've seen.  But there are larger, social issues, that probably need
to be answered first (like convincing Linus and others that this is
really needed).

> > But if it is, a lot of character drivers need to be audited...
> 
> What has to be done there?

I haven't seen a patch yet, to really know what will be necessary.  But
for one, a lot of drivers have static arrays where they just "know" that
there can't be more than 256 minors under their control.

As a small example, look at all of the static arrays of struct
tty_struct * for all of the tty drivers :(

thanks,

greg k-h
