Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131676AbRC0WDh>; Tue, 27 Mar 2001 17:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbRC0WD1>; Tue, 27 Mar 2001 17:03:27 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15633
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131657AbRC0WDV>; Tue, 27 Mar 2001 17:03:21 -0500
Date: Tue, 27 Mar 2001 14:02:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@transmeta.com>,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.31.0103271333160.25014-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10103271359590.17821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Linus Torvalds wrote:

> 
> 
> On Tue, 27 Mar 2001, Alan Cox wrote:
> >
> > > layer made it impossible for a driver writer to be nice to the user, so
> > > instead they got their own major numbers.
> >
> > Not deficiencies in the SCSI layer, there is no way the scsi layer can
> > handle high end raid controllers. In fact one of the reasons we can beat
> > NT with some of these controllers is because NT does exactly what you
> > suggest with scsi miniport driver hacks and it _sucks_. Its an ugly hack.
> 
> We could do this fairly _trivially_ today.
> 
> With absolutely no performance degradation.
> 
> With a simple "queue" mapping for the SCSI majors. Just look up which
> queue to use for requests to which major, and you're done. The actual
> IO may by-pass the SCSI layer altogether.
> 
> So I'm absolutely not advocating using the SCSI layer for the
> high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> hogging a major number, but letting low-level drivers get at _their_
> requests directly.

Am I hearing you state you want dynamic device points and dynamic majors?
Thus would be nice because the ridge structure now prevents a lot if
things from developing.

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

