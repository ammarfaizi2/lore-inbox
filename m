Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBFT0F>; Tue, 6 Feb 2001 14:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBFTZ4>; Tue, 6 Feb 2001 14:25:56 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:1289
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129138AbRBFTZm>; Tue, 6 Feb 2001 14:25:42 -0500
Date: Tue, 6 Feb 2001 11:25:00 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
In-Reply-To: <20010206181808.I1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061122530.2273-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Tue, Feb 06, 2001 at 05:54:41PM +0000, David Woodhouse wrote:
> > 
> > sct@redhat.com said:
> > >  Linux will obey that if it possibly can: only in cases where the
> > > hardware is actively lying about when the data has hit disk will the
> > > guarantee break down. 
> > 
> > Do we attempt to ask SCSI disks nicely to flush their write caches in this 
> > situation? cf. http://www.danbbs.dk/~dino/SCSI/SCSI2-09.html#9.2.18
> 
> No, we simply omit to instruct them to enable write-back caching.
> Linux assumes that the WCE (write cache enable) bit in a disk's
> caching mode page is zero.

Stephen,

You can not be so blind to omit the command.
You have to issue an active command to disable WCE.
All modern drives come with it defaulted enabled, especially ATA disks.

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
