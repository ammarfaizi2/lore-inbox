Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWEOXiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWEOXiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWEOXiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:38:04 -0400
Received: from mx.pathscale.com ([64.160.42.68]:15246 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750789AbWEOXiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:38:01 -0400
Message-ID: <53739.71.131.57.117.1147736281.squirrel@rocky.pathscale.com>
In-Reply-To: <adaslnarhpv.fsf@cisco.com>
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
    <adazmhjth56.fsf@cisco.com>
    <1147727447.2773.14.camel@chalcedony.pathscale.com>
    <60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
    <ada64k6sx7w.fsf@cisco.com>
    <40771.71.131.57.117.1147735500.squirrel@rocky.pathscale.com>
    <adaslnarhpv.fsf@cisco.com>
Date: Mon, 15 May 2006 16:38:01 -0700 (PDT)
Subject: Re: [openib-general] Re: [PATCH 53 of 53] ipath - add memory 
     barrier when waiting for writes
From: ralphc@pathscale.com
To: "Roland Dreier" <rdreier@cisco.com>
Cc: ralphc@pathscale.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     ralphc> We had a power failure here so I'm not able to reproduce
>     ralphc> the assembly code at the moment.  What I remember from
>     ralphc> looking at the code is that the code for
>     ralphc> ipath_read_kreg32() was present in i2c_wait_for_writes()
>     ralphc> when compiled -Os so it didn't look like a compiler bug.
>     ralphc> I probably could put the mb() at the end of i2c_gpio_set()
>     ralphc> if that makes you more comfortable.  The mb() is
>     ralphc> definitely needed though.
>
> Is it the mb()?  Or is just a barrier() enough?  In other words do you
> really need the mfence, or do you just need to stop the compiler from
> reordering things?
>
>  - R.

I didn't try calling barrier() so I don't know the answer.
When power is restored, I can try it.
My guess is that it's a timing issue and not a code reordering
issue.

