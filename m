Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCXVA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCXVA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVCXU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:59:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55273 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261318AbVCXU6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:58:01 -0500
Message-ID: <424329C2.6050005@pobox.com>
Date: Thu, 24 Mar 2005 15:57:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Luc Cooke <jlcooke@certainkey.com>
CC: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com> <20050324142540.GI24697@certainkey.com>
In-Reply-To: <20050324142540.GI24697@certainkey.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Cooke wrote:
> On Thu, Mar 24, 2005 at 07:48:18AM -0500, Jeff Garzik wrote:
> 
>>If you want to add entropy to the kernel entropy pool from hardware RNG, 
>>you should use the userland daemon, which detects non-random (broken) 
>>hardware and provides throttling, so that RNG data collection does not 
>>consume 100% CPU.
>>
>>If you want to use the hardware RNG directly, it's simple:  just open 
>>/dev/hw_random.
>>
>>Hardware RNG should not go kernel->kernel without adding FIPS tests and 
>>such.
> 
> 
> If your RNG were properly written, it shouldn't matter if the data you're
> pumping into /dev/random passed muster or not.  If you're tracking entropy
> count, then that's a different story of course.

It's rather lame to add data, without also crediting entropy.

Further, it wastes many CPU cycles in many places, if you are doing 
nothing but pumping bad data (all 1's, for example) into /dev/random.


> I've been commissioned to write Fortuna RNG for Linux and weddings, houses and
> cars not withstanding, I should I it ready soon to be given to LKML for
> digestion.

Sounds great.

	Jeff


