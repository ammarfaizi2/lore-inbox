Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317791AbSHHRjx>; Thu, 8 Aug 2002 13:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSHHRjw>; Thu, 8 Aug 2002 13:39:52 -0400
Received: from reload.namesys.com ([212.16.7.75]:20619 "EHLO
	reload.namesys.com") by vger.kernel.org with ESMTP
	id <S317791AbSHHRjk>; Thu, 8 Aug 2002 13:39:40 -0400
Date: Thu, 8 Aug 2002 21:43:17 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jesse Barnes <jbarnes@sgi.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808174317.GG8804@reload.namesys.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Jesse Barnes <jbarnes@sgi.com>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, phillips@arcor.de, rml@tech9.net
References: <20020808170824.GA29468@sgi.com> <Pine.LNX.4.44L.0208081430310.2589-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208081430310.2589-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 02:31:40PM -0300, Rik van Riel wrote:
> On Thu, 8 Aug 2002, Jesse Barnes wrote:
> > On Thu, Aug 08, 2002 at 08:00:45AM +0200, Jens Axboe wrote:
> 
> > > For MUST_NOT_HOLD to work, you need to take into account which processor
> > > took the lock etc.
> 
> [snip]
> 
> > Agreed.  I'll post another patch that doesn't mess with the scsi
> > stuff.  Maybe later I can put together a useful
> > 'lock-not-held-on-this-cpu' macro.
> 
> You don't need to put this in a macro.  This test is valid
> for ALL spinlocks in the kernel and can be done from inside
> the spin_lock() macro itself, when spinlock debugging is on.
> 

This is just not true.  When you make this assertion, it doesn't mean you
intend to take the lock.  It could have to do with lock ordering, or it could
be testing that some lock is properly released.  Why do you seem to be against
more assertions?  They won't get in your way.

-josh
