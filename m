Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278727AbRJVLd3>; Mon, 22 Oct 2001 07:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRJVLdT>; Mon, 22 Oct 2001 07:33:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22712 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278727AbRJVLdJ>;
	Mon, 22 Oct 2001 07:33:09 -0400
Date: Mon, 22 Oct 2001 07:33:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <25634.1003749468@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0110220724120.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Keith Owens wrote:

> >MODULES_BLKDEV(), MODULE_LDISC(), etc. would be trivial wrappers around that.
> 
> Everything is a device and can be handled by the hotplug project.  It
> is really a cunning plan by David Brownell and Greg Kroah-Hartman to
> own the entire device subsystem ;).

No-go - we need that for filesystems.  But that's a separate story - if
MODULE_CONF() is there life already becomes much easier.
 
> >Looks like the thing you mentioned would make quite a few people happy.
> >Might be worth doing in 2.4...
> 
> Please, no more 2.4 changes.  Let Linus get 2.4 stable, fork 2.5 so we
> can break it on a daily basis then backport to 2.4 when it works.

I suspect that in this case s/2.5/2.4-ac/ might be a possibility.  Since
we are talking about defaults, nothing is going to break if file simply
doesn't exist.  So teaching modprobe to handle it if it's there would
be a compatible change and would allow testing the kernel side of that
stuff.  Alan?


