Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVBHJrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVBHJrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVBHJrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:47:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22150 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261502AbVBHJqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:46:45 -0500
Date: Tue, 8 Feb 2005 10:46:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
Message-ID: <20050208094634.GE15985@suse.de>
References: <1865944987.20050207081532@dns.toxicfilms.tv> <20050208010024.7071e5f7.akpm@osdl.org> <20050208093713.GC15985@suse.de> <20050208014433.42320fc4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208014433.42320fc4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  > 	        ->axboe!
> > 
> >  :-)
> > 
> >  The thing wants a rewrite. Ideally the serializing point would be a
> >  special request. The patch is still better than nothing right now, it's
> >  really easy to hang the device with hdparm in -linus since it's
> >  impossible to guess when it is safe to issue tuning actions from user
> >  space.
> 
> I'm not sure which is worse, really.  I've never hung an interface with
> hdparm, nor seen any reports of it.  Making I/O errors deadly rather hurts.

I've gotten several reports of it, try to tune the drive settings with
any kind of drive activity and it will barf.

>  Will it happen on all I/O errors, or was this a special case?

Not sure, at least the crc stuff will trigger it. If you want you can
deactivate the patch for now, I'll get it fixed properly.

-- 
Jens Axboe

