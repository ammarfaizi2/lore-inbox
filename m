Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSHHRE4>; Thu, 8 Aug 2002 13:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317662AbSHHRE4>; Thu, 8 Aug 2002 13:04:56 -0400
Received: from rj.SGI.COM ([192.82.208.96]:53731 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317661AbSHHREz>;
	Thu, 8 Aug 2002 13:04:55 -0400
Date: Thu, 8 Aug 2002 10:08:24 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808170824.GA29468@sgi.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
References: <20020807205134.GA27013@sgi.com> <Pine.LNX.4.44L.0208071758280.23404-100000@imladris.surriel.com> <20020807210855.GA27182@sgi.com> <20020808060045.GM2243@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808060045.GM2243@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 08:00:45AM +0200, Jens Axboe wrote:
> The SCSI ASSERT_LOCK() were never used from kernel space, they are for
> the user space similator. So it was always single threaded from there
> and has no bearing on what actual kernel code does.
> 
> For MUST_NOT_HOLD to work, you need to take into account which processor
> took the lock etc.

That's the only way it seems to be useful...

> > After I posted the last patch, a few people asked for MUST_NOT_HOLD so
> > I added it back in.  Do you think it's a bad idea?  See the last
> 
> Your current version is surely worthless.

Agreed.  I'll post another patch that doesn't mess with the scsi
stuff.  Maybe later I can put together a useful
'lock-not-held-on-this-cpu' macro.

Thanks,
Jesse
