Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTIEBFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbTIEBFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:05:19 -0400
Received: from [209.195.52.120] ([209.195.52.120]:14063 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261428AbTIEBFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:05:12 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nuno Silva <nuno.silva@vgertech.com>, Wes Felter <wesley@felter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 4 Sep 2003 18:02:08 -0700 (PDT)
Subject: Re: Remote SCSI Emulation
In-Reply-To: <1062723666.23275.10.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309041759530.18624-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Alan Cox wrote:

> On Gwe, 2003-09-05 at 00:59, David Lang wrote:>
> > > Another, more generic, solution is "ip over scsi":
> > >
> > > http://www.google.com/search?q=%22ip+over+scsi%22
> >
> > Actually, ip over scsi cannot accomplish the goal listed above.
>
> No, it can instead replace much of it with a better infrastructure as
> can ATA over ethernet. Or you can push the whole problem up to fs level
> and you get stuff like LUSTRE
>
> > what is beeing looked for here is the scsi equivalent of the USB 'gadget'
> > driver, letting linux be at the slave end of things as well as the master.
>
> Which is a strange place to put a Linux box but I guess you might want
> to build a legacy SCSI raid box that way as opposed to iSCSI.

that's exactly what I think is being asked about. make it look to the host
system like a standard legacy SCSI drive, but under the covers take
advantage of all the things that linux can do (cheap IDE drives, raid,
snapshots, journaling (only partially useful), etc)

David Lang

> > does anyone have an idea why *BSD was able to do this, but all the linux
> > projects seem to get stuck half-finished? is this just added complexity
> > due to the large number of linux scsi drivers or is there something deeper
> > in the system?
>
> You need to add target support to some of the drivers and probably a
> chunk of infrastructure as well. I suspect someone did the job for BSD
> and since its pretty rarely needed and its normally in a closed box
> where the core OS being Linux doesn't matter everyone else just used BSD
> for that job.
>
>
