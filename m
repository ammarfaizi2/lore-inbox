Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWH1B24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWH1B24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWH1B24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:28:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43679 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932313AbWH1B24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:28:56 -0400
Date: Mon, 28 Aug 2006 11:28:30 +1000
From: David Chinner <dgc@sgi.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060828012830.GH807830@melbourne.sgi.com>
References: <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com> <17641.24478.496091.79901@cse.unsw.edu.au> <20060821135132.GG4290@suse.de> <17646.32332.572865.919526@cse.unsw.edu.au> <20060825063723.GO24258@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825063723.GO24258@kernel.dk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:37:24AM +0200, Jens Axboe wrote:
> On Fri, Aug 25 2006, Neil Brown wrote:
> 
> > I'm beginning to think that the current scheme really works very well
> > - except for a few 'bugs'(*).
> 
> It works ok, but it makes it hard to experiment with larger queue depths
> when the vm falls apart :-). It's not a big deal, though, even if the
> design isn't very nice - nr_requests is not a well defined entity. It
> can be anywhere from 512b to megabyte(s) in size. So throttling on X
> number of requests tends to be pretty vague and depends hugely on the
> workload (random vs sequential IO).

So maybe we need a different control parameter - the amount of memory we
allow to be backed up in a queue rather than the number of requests the
queue can take...

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
