Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCXUhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCXUhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCXUhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:37:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34536 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261160AbVCXUhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:37:22 -0500
Message-ID: <424324F1.8040707@pobox.com>
Date: Thu, 24 Mar 2005 15:37:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
CC: cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	<20050323203856.17d650ec.akpm@osdl.org> <m1y8cc3mj1.fsf@muc.de>
In-Reply-To: <m1y8cc3mj1.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> 
>>David McCullough <davidm@snapgear.com> wrote:
>>
>>>Here is a small patch for 2.6.11 that adds a routine:
>>>
>>> 	add_true_randomness(__u32 *buf, int nwords);
>>
>>It neither applies correctly nor compiles in current kernels.  2.6.11 is
>>very old in kernel time.
>>
>>Are we likely to see any in-kernel users of this?
> 
> 
> I added similar support to the pre hw_random AMD8111 driver
> a long time ago. Basically a timer that regularly read some
> dat from the hw random generator and feed it into the random
> code.
> 
> I think it is a good idea, because it doesnt make much sense
> imho to run a daemon for something that can be done in 20 lines
> of code in the kernel.

Check your kernel history.

We -used- to need data from RNG directly into the kernel randomness 
pool.  The consensus was that the FIPS testing should be moved to userspace.

	Jeff



