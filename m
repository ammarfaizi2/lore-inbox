Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVGDUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVGDUXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVGDUXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:23:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12421 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261640AbVGDUWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:22:38 -0400
Date: Mon, 4 Jul 2005 15:03:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704130336.GB3449@openzaurus.ucw.cz>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050704072231.GG1444@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > This is exactly what I said. Use hdparm to make the HD park 
> > > > inmediatelly. I did send the email to the HDPARM developer, but he never 
> > > > replied. I asked him what would be the best way to make the HD park with 
> > > > no exception and then let it come back 5 or 10 seconds later.
> > > 
> > > IIRC, you don't have to do anything to wake up the drive after a
> > > STANDBYNOW command, if you want to be on the safe side you just issue an
> > > IDLEIMMEDIATE. So your code will look something like:
> > 
> > the problem for this will be that this app will also want to prevent ANY
> > io going to the disk for a few seconds.
> > 
> > I mean, what use is parking the head if you notice the laptop falling,
> > when the kernel submits IO to it and wakes it up again before it hits
> > the ground :)
> 
> Yeah, that likely needs a little help from the ide driver. If you force
> a spindown, you will effectively have parked the head for as long as the
> spindown + spinup takes. That could turn out to be enough, it will take
> more than 1-2 seconds anyways.

Actually, "spin disk down and keep it down" would be nice for other
reasons. Taking computer for a jog playing mp3s from ramdisk is
something I'd like to do...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

