Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCYEtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCYEtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCYEtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:49:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9119 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261289AbVCYEtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:49:15 -0500
Message-ID: <42439839.7060702@pobox.com>
Date: Thu, 24 Mar 2005 23:48:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: johnpol@2ka.mipt.ru
CC: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>	 <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
In-Reply-To: <1111725282.23532.130.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, 2005-03-24 at 15:56 -0500, Jeff Garzik wrote:
>>See the earlier discussion, when data validation was -removed- from the 
>>original Intel RNG driver, and moved to userspace.
> 
> I'm not arguing against userspace validation, but if data produced
> _is_ cryptographically strong, why revalidate it again?

You cannot prove this without validating the data in software.

Otherwise, you are not handling the hardware-fault case.

It is foolish to presume that hardware always works correctly.  It is 
-very- foolish to presume this, in cryptography.


> And how HIFN driver can contribute entropy?

Use the current chrdev->rngd method.


> You may say, that hardware can be broken and thus produces 
> wrong data, but if user want, it can turn it on or off.

The user cannot know the data is bad unless it is constantly being 
validated.

	Jeff


