Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWB0O1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWB0O1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWB0O1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:27:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27598 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751243AbWB0O1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:27:20 -0500
Subject: Re: o_sync in vfat driver
From: Arjan van de Ven <arjan@infradead.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1141049176.18855.4.camel@imp.csi.cam.ac.uk>
References: <op.s5cj47sxj68xd1@mail.piments.com>
	 <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com>
	 <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com>
	 <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com>
	 <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com>
	 <20060227132848.GA27601@csclub.uwaterloo.ca>
	 <1141048228.2992.106.camel@laptopd505.fenrus.org>
	 <1141049176.18855.4.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 15:27:16 +0100
Message-Id: <1141050437.2992.111.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 14:06 +0000, Anton Altaparmakov wrote:
> On Mon, 2006-02-27 at 14:50 +0100, Arjan van de Ven wrote:
> > On Mon, 2006-02-27 at 08:28 -0500, Lennart Sorensen wrote:
> > > On Sun, Feb 26, 2006 at 11:50:40PM +0100, col-pepper@piments.com wrote:
> > > > Hi,
> > > > 
> > > > OMG what do I have to do to post here? 10th attempt.
> > > > {part2}
> > > > 
> > > > Here is a non-exhaustive list of typical devices types requiring fat vfat
> > > > support:
> > > > 
> > > > fd ide-hd scsi-hd usb-hd cdrom usb-hd usb-handheld (iPod, iRiver etc)
> > > > usb-flash (usbsticks, cameras, some music devices.)
> > > > 
> > > > IIRC the sync mount option for vfat is ignored for file systems >2G, this
> > > > effectively (and probably intentionally) excludes nearly all hd partitions
> > > > and iPod type devices.
> > > 
> > > I think many people wish it was ignored on smaller devices too given
> > > what it does to write performance.
> > 
> > well. If you don't want it *DO NOT USE IT AT THE MOUNT COMMAND LINE* !!!
> 
> That is easy to say when you are using the command line...  Modern
> distros (as you know I am sure) mount all hot-plug devices like usb
> keys, usb hard disks, etc automatically at plug-in time and at least
> some distros use "-o sync"

that is a bad misdesign of that distro or at least the tool the distro
uses for this (I don't know which it is so I can say that without
sounding partial :)

the tool that decides to use "sync", or at least the author thereof,
should be aware of what flash is, and that it has a limited lifespan etc
etc, and that you thus want maximum caching etc.



