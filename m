Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHGVgT>; Wed, 7 Aug 2002 17:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHGVgT>; Wed, 7 Aug 2002 17:36:19 -0400
Received: from rj.SGI.COM ([192.82.208.96]:4567 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313181AbSHGVgQ>;
	Wed, 7 Aug 2002 17:36:16 -0400
Date: Wed, 7 Aug 2002 14:39:49 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
       rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020807213949.GA27258@sgi.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org, jmacd@namesys.com, phillips@arcor.de,
	rml@tech9.net
References: <20020807210855.GA27182@sgi.com> <Pine.LNX.4.44L.0208071814250.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0208071814250.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 06:21:07PM -0300, Rik van Riel wrote:
> On Wed, 7 Aug 2002, Jesse Barnes wrote:
> > macro worked before?  I could just remove all those checks in the scsi
> > code I guess.
> 
> That would be a better option.

Ok.

> The MUST_NOT_HOLD basically means the kernel will OOPS the
> moment the lock is contended.

I think those macros were intended to enforce lock ordering in the
scsi layer (though I'm not sure).  At any rate, there are much better
ways to enforce proper lock ordering, and the scsi layer could be
updated when/if we get one.

> If you want to detect lock recursion on the same CPU, I'd
> suggest the following:
> ...

Of course, that's what the lockmetering code does, IIRC, but I think
that's a feature for a seperate patch.

Thanks,
Jesse
