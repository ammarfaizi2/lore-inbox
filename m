Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbTCHA5j>; Fri, 7 Mar 2003 19:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTCHAzO>; Fri, 7 Mar 2003 19:55:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:29602 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261731AbTCHAyj>;
	Fri, 7 Mar 2003 19:54:39 -0500
Date: Fri, 7 Mar 2003 17:05:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-Id: <20030307170520.5e38c3c9.akpm@digeo.com>
In-Reply-To: <20030308005018.GE23071@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	<20030307193644.A14196@infradead.org>
	<20030307123029.2bc91426.akpm@digeo.com>
	<20030307221217.GB21315@kroah.com>
	<20030307143319.2413d1df.akpm@digeo.com>
	<20030307234541.GG21315@kroah.com>
	<1047086062.24215.14.camel@irongate.swansea.linux.org.uk>
	<20030308005018.GE23071@kroah.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2003 01:05:08.0394 (UTC) FILETIME=[C30458A0:01C2E50E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Sat, Mar 08, 2003 at 01:14:23AM +0000, Alan Cox wrote:
> > On Fri, 2003-03-07 at 23:45, Greg KH wrote:
> > > I would too.  Andries's patches look like the right thing to do, so far
> > > as I've seen.  But there are larger, social issues, that probably need
> > > to be answered first (like convincing Linus and others that this is
> > > really needed).
> > > 
> > > > > But if it is, a lot of character drivers need to be audited...
> > > > 
> > > > What has to be done there?
> > > 
> > > I haven't seen a patch yet, to really know what will be necessary.  But
> > > for one, a lot of drivers have static arrays where they just "know" that
> > > there can't be more than 256 minors under their control.
> > 
> > So we need a maxminors flag in the register for 2.6 I guess ?
> 
> Do you mean to only increase the number of majors, and not minors then?
> 

Some time back Linus expressed a preference for a 2^20 major / 2^12 minor split.
