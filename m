Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbTIJX5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbTIJX5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:57:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7894 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266074AbTIJX5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:57:52 -0400
Date: Wed, 10 Sep 2003 16:46:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] you have how many nodes??
Message-ID: <41000000.1063237600@flay>
In-Reply-To: <20030910153601.36219ed8.akpm@osdl.org>
References: <20030910213602.GC17266@sgi.com><20030910151254.52f53e62.akpm@osdl.org><20030910223430.GA18244@sgi.com> <20030910153601.36219ed8.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I think.  We could just say "dang numaq needs five bits", so:
>> > 
>> > 
>> > 	# if BITS_PER_LONG == 32
>> > 	# define ZONE_SHIFT 5
>> > 	# else
>> > 	# define ZONE_SHIFT 10
>> > 	# endif
>> 
>> That's fine with me, do you want me to rediff and send a new patch?
> 
> Well your patch as it stands would appear to break NUMAQ builds, due to
> NUMAQ setting MAX_NUMNODES directly in the arch code.  ia64 is using
> another layer of macroification via NR_NODES instead.
> 
> MAX_NUMNODES, NR_NODES and MAX_NR_NODES appear to be a bit of a mess, and
> they should all be replaced with shift distances anyway.

;-)

Yes, it's a turgid mess.

I'd prefer to define things in terms of MAX_NUMNODES, and derive the shifts
from that if possible - much more intuitive to maintain.
But other than that I agree completely with you.
 
> Could you please get together with Martin Bligh, come up with something
> which works on NUMAQ and your 128 CPU PDA and also cast an eye across the
> other architectures (sparc64, sh, ...)?  It all needs a bit of thought and
> a spring clean.

I'll have a look, I'm sure we can come up with something between us.

M.

