Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVCXUyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVCXUyC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCXUyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:54:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38633 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261287AbVCXUxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:53:31 -0500
Message-ID: <424328B9.8030909@pobox.com>
Date: Thu, 24 Mar 2005 15:53:13 -0500
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
References: <20050315133644.GA25903@beast>  <20050324042708.GA2806@beast>	 <1111665551.23532.90.camel@uganda>  <4242B712.50004@pobox.com> <1111669707.23532.100.camel@uganda>
In-Reply-To: <1111669707.23532.100.camel@uganda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> hw_random can not and will not support HIFN, freescale, ixp and 
> great majority of the existing and future HW crypto devices.
> I mean that userspace daemon(or any other one) which want to contribute
> entropy
> should use crypto framwork to obtain all it's data, but not different
> access methods for each separate driver.


I don't mean to imply that hw_random should be modified to support all 
hardware RNGs.  Separate drivers are perfectly OK with me.  I would even 
take patches that split up hw_random into an RNG registration interface, 
and AMD/Intel/VIA support modules.

The part I disagree with is direct kernel->kernel RNG usage, with no 
intervening checks.

This has all been discussed years ago, when the FIPS testing was in the 
kernel (and then removed, per consensus).

	Jeff


