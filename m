Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbVCXFRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVCXFRZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVCXFRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:17:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60594 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262406AbVCXFRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:17:20 -0500
Message-ID: <42424D52.7070508@pobox.com>
Date: Thu, 24 Mar 2005 00:17:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast>	<20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org>
In-Reply-To: <20050323203856.17d650ec.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> David McCullough <davidm@snapgear.com> wrote:
> 
>>Here is a small patch for 2.6.11 that adds a routine:
>>
>> 	add_true_randomness(__u32 *buf, int nwords);
> 
> 
> It neither applies correctly nor compiles in current kernels.  2.6.11 is
> very old in kernel time.

Hrm.  This is getting pretty lame, if you can't take patches from the 
-latest- stable release.  It's pretty easy in BK:

	bk clone -ql -rv2.6.11 linux-2.6 rng-2.6.11
	cd rng-2.6.11
	{ apply patch }
	bk pull ../linux-2.6

Can you set up something like that?


> Are we likely to see any in-kernel users of this?

We already have a hardware RNG system.  This is completely unneeded.

	Jeff


