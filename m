Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVBSFVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVBSFVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 00:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBSFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 00:21:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36285 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261629AbVBSFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 00:21:00 -0500
Message-ID: <4216CCAC.1050807@pobox.com>
Date: Sat, 19 Feb 2005 00:20:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Gortmaker <penguin@muskoka.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
References: <41DED9FA.7080106@pobox.com>  <41DF9AC1.2010609@muskoka.com>	 <1105197689.10505.22.camel@localhost.localdomain>	 <41E1EB68.5000709@muskoka.com> <1105381093.12028.81.camel@localhost.localdomain>
In-Reply-To: <1105381093.12028.81.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-01-10 at 02:41, Paul Gortmaker wrote:
> 
>>Using rdtscl over the  area affected by the patch on the two variants for a
>>sample  of 234 small packets, I see an average of 4141 for using the
>>existing stack scratch area, and 4162 for using skb_padto.   That is a
>>difference of about 0.5%, which is significantly less than the typical
>>spread in the samples themselves.  To help give a relevant scale,  feeding
>>it a larger 1400 byte packet comes in at around 60,000 cycles on this
>>particular box.   Am I being optimistic to see this as good news -- meaning
>>that there is no longer a need for driver specific padto implementations,
>>whereas it looks like there was back when you did your tests? 
> 
> 
> It means that padto has improved a lot (or the underlying allocators).
> It also still means the patch makes the code slower and introduces
> changes that have no benefit into the kernel, so while its good to see
> its not relevant its still a pointless change.

So the verdict is to revert?

	Jeff



