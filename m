Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVC2V5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVC2V5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVC2V5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:57:32 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27781 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261452AbVC2V5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:57:25 -0500
Message-ID: <4249D06F.30802@tmr.com>
Date: Tue, 29 Mar 2005 17:02:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <1111731361.20797.5.camel@uganda><1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au>
In-Reply-To: <20050325061311.GA22959@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

> You missed the point.  This has nothing to do with the crypto API.
> Jeff is saying that if this is disabled by default, then only a few
> users will enable it and therefore use this API.
> 
> Since we can't afford to enable it by default as hardware RNG may
> fail which can lead to catastrophic consequences, there is no point
> for this API at all.

Wait a minute, if it fails the system drops back to software, which is 
not as good in a pedantic analysis, but perhaps falls a good bit short 
of "catastrophic consequences" as most people would characterize that 
phrase. And more to the point, now that many CPUs and chipsets are the 
RNG of choice, what is the actual probability of a failure of the RNG 
leaving a functional system (that's a real question seeking response 
from someone who has some actual data).

It would be desirable for the kernel to detect a failure and do 
something appropriate, but I have to feel that if an RNG is in the CPU 
or chipset, it would serve users better to use it. By default. People 
who need quality entropy would be better served by a hardware source, 
and people who don't (or fail to realize they do) would not be hurt by 
use of better numbers.

I'm not sure you would get people to agree what should be done if a 
hardware RNG fails, other than make the failure information available to 
user space.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
