Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbTCWQVV>; Sun, 23 Mar 2003 11:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbTCWQVV>; Sun, 23 Mar 2003 11:21:21 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:43277 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263105AbTCWQVU>; Sun, 23 Mar 2003 11:21:20 -0500
Date: Sun, 23 Mar 2003 16:32:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] alternative dev patch
Message-ID: <20030323163223.A9499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	akpm@digeo.com
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com> <Pine.LNX.4.44.0303210936590.5042-100000@serv> <20030322013800.GD18835@kroah.com> <Pine.LNX.4.44.0303221306350.5042-100000@serv> <20030323081956.GK26145@kroah.com> <Pine.LNX.4.44.0303231557230.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303231557230.5042-100000@serv>; from zippel@linux-m68k.org on Sun, Mar 23, 2003 at 04:05:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 04:05:24PM +0100, Roman Zippel wrote:
> > Yeah, but as I know, it's a big pain in the butt.  Let's make it easy to
> > do this, don't make writing a driver tougher than it has to be (it's
> > already much harder than it used to be.)  Andries's patch makes it easy,
> > which is a good thing in my book.
> 
> Andries' patch doesn't help at all and only makes things worse. Only very 
> few drivers should have to deal with the major/minor business. Most 
> drivers should just do add_serial_device/add_tape_device/... and these 
> function will do the right thing (e.g. announce the new device via sysfs).

Yupp.  The add_serial_device/add_tape_device/ would also have the benefit
that they could keept track of devfs like the gendisk handling when
GENHD_FL_DEVFS is set by the drivers - lots of cruft can be remove from
drivers and midlayers incrementally.

