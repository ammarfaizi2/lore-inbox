Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWF0NeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWF0NeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWF0NeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:34:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47370 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932448AbWF0NeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:34:09 -0400
Date: Tue, 27 Jun 2006 15:35:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org
Subject: Re: 2.6.17-ck1: fcache problem...
Message-ID: <20060627133544.GW22071@suse.de>
References: <20060625093534.1700e8b6@localhost> <20060625102837.GC20702@suse.de> <20060625152325.605faf1f@localhost> <20060625174358.GA21513@suse.de> <20060627112105.0b15bfa1@localhost> <20060627095443.GQ22071@suse.de> <20060627122457.2cabc4d7@localhost> <20060627150440.0aaf07e1@localhost> <20060627131033.GU22071@suse.de> <20060627153043.60582710@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627153043.60582710@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27 2006, Paolo Ornati wrote:
> On Tue, 27 Jun 2006 15:10:33 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > > Cannot the code figure out this himself al let "mount -o remount,ro"
> > > work?
> > 
> > It could be fixed up, yes, but for now you have to always pass the fdev
> > option for it to work. Sorry, I thought you knew that, I think I wrote
> > that in the original mail as well.
> 
> No ;)
> 
> http://lkml.org/lkml/2006/5/15/46
> 
> you talked about remounting rw at boot (modifing distro script) and
> remounting for stopping priming.

I guess not, I've not noticed since my modified suse boot.rootfs script
use FCACHE_ARGS for both mount rw and remount ro. I does tell you to use
fdev for rw remounts though, so it's not like I didn't hint at it at
least :-)

> > But it needs to be fixed of course, also so you don't have to do it for
> > 'rw' remounts (which I sometimes do just to check stats).
> 
> I agree :)

Will fix it up, for now just pass fdev= always.

-- 
Jens Axboe

