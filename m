Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291298AbSBGVBY>; Thu, 7 Feb 2002 16:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291305AbSBGVBH>; Thu, 7 Feb 2002 16:01:07 -0500
Received: from air-2.osdl.org ([65.201.151.6]:36533 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291308AbSBGU7w>;
	Thu, 7 Feb 2002 15:59:52 -0500
Date: Thu, 7 Feb 2002 12:59:50 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <Pine.GSO.4.21.0202071526080.25715-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0202071252010.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Alexander Viro wrote:

> 
> 
> On Thu, 7 Feb 2002, Patrick Mochel wrote:
> 
> > It is really nice, but it's too much for the common case. The goal is to 
> > have each file export one and only one value. Setting up an iterator is 
> > overkill for one value.
> 
> You don't have to use the iterator side of that.

Well, I'll be...

I like the seq_ stuff, and the ->read() side of things take care of the 
issues discussed in this thread. What's even nicer is that if I convert to 
that, driver callbacks become something like either:

int driver_show(struct device * dev, struct seq_file * m)

or 

int driver_show(struct device * dev, char * buf)


Have you considered doing write()?

	-pat

