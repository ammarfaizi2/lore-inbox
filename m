Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWH3PGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWH3PGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWH3PGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:06:36 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:35203 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1750946AbWH3PGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:06:35 -0400
Date: Wed, 30 Aug 2006 18:05:36 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060830150535.GA30172@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060830144646.GC1923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830144646.GC1923@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Pavel Machek <pavel@suse.cz>:
> Subject: Re: T60 not coming out of suspend to RAM
> 
> Hi!
> 
> > > > > > OK, it turns out the problem was with running SATA drive in AHCI mode.
> > > > > > 
> > > > > > After applying the following patch from Forrest Zhao
> > > > > > http://lkml.org/lkml/2006/7/20/56
> > > > > > both suspend to disk and suspend to ram work fine now.
> > > > > > This patch is going into 2.6.18, isn't it?
> > > > > 
> > > > > Not sure, check latest -rc5, and if it is not there, ask akpm...
> > > > > 
> > > > 
> > > > Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.
> > > > 
> > > 
> > > It looks like Forrest's stuff is all queued up in the libata devel tree,
> > > although in a significantly different-looking form.
> > > 
> > > So no, right now it doesn't look good for 2.6.18.
> > > 
> > 
> > Ugh, more's the pity :( How about merging this one patch? T60 is only half
> > as useful without it (no disk after resume), and the rate of changes in
> > libata is high so just using a patch is gonnu be painful in the long run.
> 
> I guess you need to convince SATA maintainer that patch is safe before
> it can go in...

Right.

Jeff, could you please ack whether the following patch from Forrest Zhao
is safe for 2.6.18?
http://lkml.org/lkml/2006/7/20/56

Without it, no disk access is possible after resume from suspend-to-ram
on my T60.

-- 
MST
