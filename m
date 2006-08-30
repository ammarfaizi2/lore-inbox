Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWH3Oq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWH3Oq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWH3Oq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 10:46:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50838 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750929AbWH3Oq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 10:46:58 -0400
Date: Wed, 30 Aug 2006 16:46:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060830144646.GC1923@elf.ucw.cz>
References: <20060828122535.911e593a.akpm@osdl.org> <20060828201934.GA26544@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828201934.GA26544@mellanox.co.il>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > OK, it turns out the problem was with running SATA drive in AHCI mode.
> > > > > 
> > > > > After applying the following patch from Forrest Zhao
> > > > > http://lkml.org/lkml/2006/7/20/56
> > > > > both suspend to disk and suspend to ram work fine now.
> > > > > This patch is going into 2.6.18, isn't it?
> > > > 
> > > > Not sure, check latest -rc5, and if it is not there, ask akpm...
> > > > 
> > > 
> > > Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.
> > > 
> > 
> > It looks like Forrest's stuff is all queued up in the libata devel tree,
> > although in a significantly different-looking form.
> > 
> > So no, right now it doesn't look good for 2.6.18.
> > 
> 
> Ugh, more's the pity :(
> How about merging this one patch? T60 is only half as useful without it (no disk
> after resume), and the rate of changes in libata is high so just using a patch
> is gonnu be painful in the long run.

I guess you need to convince SATA maintainer that patch is safe before
it can go in...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
