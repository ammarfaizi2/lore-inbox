Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130738AbRBGAnw>; Tue, 6 Feb 2001 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130638AbRBGAnm>; Tue, 6 Feb 2001 19:43:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:39433
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130738AbRBGAnZ>; Tue, 6 Feb 2001 19:43:25 -0500
Date: Tue, 6 Feb 2001 16:42:32 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
In-Reply-To: <20010206232119.K1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061630490.2656-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:

> The ll_rw_block interface is perfectly clear: it expects the data to
> be written to persistent storage once the buffer_head end_io is
> called.  If that's not the case, somebody needs to fix the lower
> layers.

Sure in 2.5 when I have a cleaner method of setting up hooks to allow
testing and changing of the mode but you can not assume that this stuff is
off by default and will stay that way.

At this time I am working to clean up an IBM mess of drives that do random
dumping of the drive cache to the platters when power is pulled.  This is
a nice dirty errata that I have heard about but have never seen, but can
believe that it is real.  The painful part is now that drives have these
huge buffers of upto 4MB, we have only a second or two to hit the platters
before the head float and spindle sync for writing depart from the
allowable range and it does not get to disk....OOPS!

I suspect that with all of the new NVRAM HOSTS coming to market soon we
will see more fs death in the future until things settle.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
