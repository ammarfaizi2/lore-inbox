Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261627AbTCHAxi>; Fri, 7 Mar 2003 19:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbTCHAwk>; Fri, 7 Mar 2003 19:52:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36876 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261700AbTCHAto>;
	Fri, 7 Mar 2003 19:49:44 -0500
Date: Fri, 7 Mar 2003 16:50:18 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308005018.GE23071@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com> <1047086062.24215.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047086062.24215.14.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 01:14:23AM +0000, Alan Cox wrote:
> On Fri, 2003-03-07 at 23:45, Greg KH wrote:
> > I would too.  Andries's patches look like the right thing to do, so far
> > as I've seen.  But there are larger, social issues, that probably need
> > to be answered first (like convincing Linus and others that this is
> > really needed).
> > 
> > > > But if it is, a lot of character drivers need to be audited...
> > > 
> > > What has to be done there?
> > 
> > I haven't seen a patch yet, to really know what will be necessary.  But
> > for one, a lot of drivers have static arrays where they just "know" that
> > there can't be more than 256 minors under their control.
> 
> So we need a maxminors flag in the register for 2.6 I guess ?

Do you mean to only increase the number of majors, and not minors then?

greg k-h
