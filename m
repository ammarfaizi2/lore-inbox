Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTIRNAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbTIRNAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:00:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60396 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261270AbTIRNAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:00:17 -0400
Date: Thu, 18 Sep 2003 15:00:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030918130008.GG21870@suse.de>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de> <20030915093221.GE2268@gamma.logic.tuwien.ac.at> <20030917075432.GG906@suse.de> <20030917194152.GD9125@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917194152.GD9125@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17 2003, Pavel Machek wrote:
> Hi!
> 
> > +So what does the laptop mode patch do? It attempts to fully utilize the
> > +hard drive once it has been spun up, flushing the old dirty data out to
> > +disk. Instead of flushing just the expired data, it will clean everything.
> > +When a read causes the disk to spin up, we kick off this flushing after
> > +a few seconds. This means that once the disk spins down again, everything
> > +is up to date. That allows longer dirty data and journal expire times.
> 
> Another nice touch would be to sync just before spinning down.
> noflushd does that... of course it needs software-controlled
> spindowns.

Yeah, my automatic acoustic management patch did that, works well in
addition to laptop mode. It's beyond the scope of this patch though,
it's just a vm flushing control.

-- 
Jens Axboe

