Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUHFFnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUHFFnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268003AbUHFFnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:43:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268095AbUHFFnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:43:10 -0400
Date: Fri, 6 Aug 2004 07:42:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040806054245.GA10274@suse.de>
References: <20040803055337.GA23504@suse.de> <41128070.5050109@tmr.com> <20040805193520.GA7571@suse.de> <1091739746.8419.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091739746.8419.35.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, Alan Cox wrote:
> On Iau, 2004-08-05 at 20:35, Jens Axboe wrote:
> > > exotic commands, and given the choice of having users able to send 
> > > arbitrary commands to the device and not access it at all, I would say 
> > > "not at all" would be good.
> > 
> > Then don't make your cdrom device accesable.
> 
> Lets get rid of root, I mean you don't need root, you could just turn
> your computer off.
> 
> What planet are you living on Jens ?

I'm living on the planet where filtering is not possible, unless you
want to have oodles of unmaintanable tables for different devices. And
that means that if you don't trust a user with your cdrom currently,
don't give him/her access to it.

> End users have lots of reasons for being able to access /dev/cdrom
> directly and also often for groups of users to access a disk directly
> (for example Oracle databases).

Yes I know.

> That means any security model that isn't based around things beyond
> basic device access is flawed.

Then we should require raw io capability, as I've stated I'm fine with
that. I'm not fine with filtering.

> > Affects all devices that accept SG_IO.
> 
> Then if you refuse to fix SG_IO perhaps all device drivers should remove
> support for it ?

Well they can't, it's a block layer property. The only thing the device
sees is a regular struct request.

-- 
Jens Axboe

