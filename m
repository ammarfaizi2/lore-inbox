Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVC2Wsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVC2Wsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVC2Wsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:48:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31695 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261589AbVC2Wq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:46:59 -0500
Message-ID: <4249DAD4.9020602@pobox.com>
Date: Tue, 29 Mar 2005 17:46:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <1111731361.20797.5.camel@uganda><1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <4249D06F.30802@tmr.com>
In-Reply-To: <4249D06F.30802@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Herbert Xu wrote:
> 
>> You missed the point.  This has nothing to do with the crypto API.
>> Jeff is saying that if this is disabled by default, then only a few
>> users will enable it and therefore use this API.
>>
>> Since we can't afford to enable it by default as hardware RNG may
>> fail which can lead to catastrophic consequences, there is no point
>> for this API at all.
> 
> 
> Wait a minute, if it fails the system drops back to software, which is 
> not as good in a pedantic analysis, but perhaps falls a good bit short 
> of "catastrophic consequences" as most people would characterize that 
> phrase. And more to the point, now that many CPUs and chipsets are the 
> RNG of choice, what is the actual probability of a failure of the RNG 
> leaving a functional system (that's a real question seeking response 
> from someone who has some actual data).

As I've said, in the past the Intel RNGs in particular -have- failed, 
but the rest of the system keeps on working just fine.

It probably depends on the hardware implementation; I think the Intel 
RNG was based on a thermal diode, or somesuch.

In the cases where an RNG has failed in the past, the system has worked 
as expected:  rngd stopped feeding data into the entropy pool.

If the VIA RNG (on-CPU) fails, that's probably indicative of a larger 
problem, though.

	Jeff


