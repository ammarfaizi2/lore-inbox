Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261611AbSJQBLt>; Wed, 16 Oct 2002 21:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261612AbSJQBLt>; Wed, 16 Oct 2002 21:11:49 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:46349 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261611AbSJQBLs>; Wed, 16 Oct 2002 21:11:48 -0400
Date: Thu, 17 Oct 2002 02:16:23 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021017011623.GA9096@compsoc.man.ac.uk>
References: <20021016164057.GB85246@compsoc.man.ac.uk> <20021016.143843.99745166.davem@redhat.com> <20021017005728.GA8267@compsoc.man.ac.uk> <20021016.175515.21904896.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.175515.21904896.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181zIA-0000Um-00*R.6bbgCfseE* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 05:55:15PM -0700, David S. Miller wrote:

>    I suppose we could do so magic to spread the cookie value across two
>    buffer entries if necessary, but that's ugly...
>    
> True.
> 
> What if you could query the cookie size at runtime?

Not sure what you mean here. The cookie is passed in the syscall, so has
to be fixed-size no matter what, right ?

> Really, if you make it long it's going to be impossible
> to support this in 32/64 environments (ppc/sparc/mips/x86_64/
> ia64/etc.)

Sure ... I suppose I'll implement both (allocation of unique ID vs. the
above) and see which is least ugly.

thanks
john
-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
