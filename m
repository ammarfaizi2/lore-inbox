Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSHHRcV>; Thu, 8 Aug 2002 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317695AbSHHRcV>; Thu, 8 Aug 2002 13:32:21 -0400
Received: from zok.SGI.COM ([204.94.215.101]:9170 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317686AbSHHRcT>;
	Thu, 8 Aug 2002 13:32:19 -0400
Date: Thu, 8 Aug 2002 10:35:51 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808173550.GA29604@sgi.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
References: <20020808170824.GA29468@sgi.com> <Pine.LNX.4.44L.0208081430310.2589-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208081430310.2589-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 02:31:40PM -0300, Rik van Riel wrote:
> > Agreed.  I'll post another patch that doesn't mess with the scsi
> > stuff.  Maybe later I can put together a useful
> > 'lock-not-held-on-this-cpu' macro.
> 
> You don't need to put this in a macro.  This test is valid
> for ALL spinlocks in the kernel and can be done from inside
> the spin_lock() macro itself, when spinlock debugging is on.

Right, right after I posted I regretted using that term.  Of course it
would have to include changes to spinlock_t and spin_lock/unlock.
Seems like it could be integrated somewhat easily with the lock
ordering stuff that was talked about earlier too.

Thanks,
Jesse
