Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTIRLgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTIRLfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:35:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65257 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261176AbTIRLfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:35:14 -0400
Date: Wed, 17 Sep 2003 21:41:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: Re: laptop mode for 2.4.23-pre4 and up
Message-ID: <20030917194152.GD9125@openzaurus.ucw.cz>
References: <20030913103014.GA7535@gamma.logic.tuwien.ac.at> <20030914152755.GA27105@suse.de> <20030915093221.GE2268@gamma.logic.tuwien.ac.at> <20030917075432.GG906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917075432.GG906@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +So what does the laptop mode patch do? It attempts to fully utilize the
> +hard drive once it has been spun up, flushing the old dirty data out to
> +disk. Instead of flushing just the expired data, it will clean everything.
> +When a read causes the disk to spin up, we kick off this flushing after
> +a few seconds. This means that once the disk spins down again, everything
> +is up to date. That allows longer dirty data and journal expire times.

Another nice touch would be to sync just before spinning down.
noflushd does that... of course it needs software-controlled
spindowns.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

