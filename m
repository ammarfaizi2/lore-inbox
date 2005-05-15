Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVEOPAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEOPAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVEOPAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 11:00:55 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:28096 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261661AbVEOPAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 11:00:49 -0400
Date: Sun, 15 May 2005 17:00:48 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <20050515145241.GA5627@irc.pl>
Message-ID: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
 <20050513211609.75216bf8.diegocg@gmail.com> <20050515095446.GE68736@muc.de>
 <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
 <20050515141207.GB94354@muc.de> <20050515145241.GA5627@irc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 May 2005, Tomasz Torcz wrote:

> On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
> > > > > However they've patched the FreeBSD kernel to "workaround?" it:
> > > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch
> > > >
> > > > That's a similar stupid idea as they did with the disk write
> > > > cache (lowering the MTBFs of their disks by considerable factors,
> > > > which is much worse than the power off data loss problem)
> > > > Let's not go down this path please.
> > >
> > > What wrong did they do with disk write cache?
> >
> > They turned it off by default, which according to disk vendors
> > lowers the MTBF of your disk to a fraction of the original value.
> >
> > I bet the total amount of valuable data lost for FreeBSD users because
> > of broken disks is much much bigger than what they gained from not losing
> > in the rather hard to hit power off cases.
>
>  Aren't I/O barriers a way to safely use write cache?

FreeBSD used these barriers (FLUSH CACHE command) long time ago.

There are rumors that some disks ignore FLUSH CACHE command just to get
higher benchmarks in Windows. But I haven't heart of any proof. Does
anybody know, what companies fake this command?

Mikulas
