Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSGYFxL>; Thu, 25 Jul 2002 01:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSGYFxL>; Thu, 25 Jul 2002 01:53:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40134 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318332AbSGYFxK>;
	Thu, 25 Jul 2002 01:53:10 -0400
Date: Thu, 25 Jul 2002 07:56:19 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
Message-ID: <20020725055619.GH5159@suse.de>
References: <1027549801.11619.2.camel@sonja.de.interearth.com> <20020724230613.27190.qmail@eklektix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724230613.27190.qmail@eklektix.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Jonathan Corbet wrote:
> > > <dalecki@evision.ag>:
> > >   o IDE-101
> > 
> > What on earth is this??? I'm really surprised you accept this as a
> > changelog entry especially when considering that there's no further
> > information about the latest IDE changes on the mailinglist anymore...
> 
> You need to look at the full changelog to see the full entry: see, for
> example: http://lwn.net/Articles/5577/.  Or, to save the wear on your web
> browser:
> 
>   <dalecki@evision.ag>
> 	[PATCH] IDE-101
> 	
> 	Here is a quick fix.  I would like to synchronize with the irq handler
> 	changes as well.  Becouse right now I know that preemption is killing
> 	the disk subsystem when moving data between disks using different
> 	request queues...  In esp.  It get's me in to do_request() with a queue
> 	in unplugged state.  (Not everything is my fault, after all :-).
           ^^^^^^^^^

must be a typo, it would be a bug to enter do_request() with the queue
in a _plugged_ state, not vice versa.

-- 
Jens Axboe

