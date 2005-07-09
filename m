Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVGIK0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVGIK0h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVGIK0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:26:37 -0400
Received: from mailfe10.swipnet.se ([212.247.155.33]:22181 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261610AbVGIK0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:26:36 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Patch for slab leak debugging
From: Alexander Nyberg <alexn@telia.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42CF919D.40009@colorfullife.com>
References: <1120856219.25294.29.camel@localhost.localdomain>
	 <20050708165554.4b958087.akpm@osdl.org>
	 <1120898643.1171.4.camel@localhost.localdomain>
	 <42CF919D.40009@colorfullife.com>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 12:26:32 +0200
Message-Id: <1120904792.1171.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Yeah I knew there was one, but I thought that was a standalone patch
> >(the one turning all bufctl to unsigned long, turning off irqs and
> >printing all slabs_full to console), my intention with this was a
> >proper /proc entry, something that could be a simple config option.
> >
> >  
> >
> No, I never wrote a proper /proc interface. But I think the bufctl 
> approach is the better solution than storing the first 5 entries in the 
> slab structure:
> What if there is a leak on a cache with more than 5 entries per slab?

As slab leaks usually go out of control I think it will be enough to
show what is leaking anyway, but you're right on the bufctl approach I
think. I may have misundersood the bufctl thing a bit before doing this.

