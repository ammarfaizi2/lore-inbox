Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWCLAcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWCLAcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 19:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWCLAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 19:32:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:63415 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751354AbWCLAcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 19:32:21 -0500
Message-ID: <44136C13.4020002@garzik.org>
Date: Sat, 11 Mar 2006 19:32:19 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AHCI prefetch
References: <20060304173505.GA28643@havoc.gtf.org> <20060310043717.GA7510@htj.dyndns.org>
In-Reply-To: <20060310043717.GA7510@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> On Sat, Mar 04, 2006 at 12:35:05PM -0500, Jeff Garzik wrote:
> 
>>This patch has been sitting in my tmp directory for ages.
>>
>>We should probably turn this on, though the practical difference is
>>probably minimal.
>>
> 
> 
> The patch works okay on my machine (ICH7R) although the patch didn't
> apply to #upstream.  I'm not very sure about this change though.
> 
> 1. Why apply it only to ATAPI devices?  ATA devices can benefit to.
>    If it's because this bit shouldn't be turned on for NCQ, we can
>    turn it on conditionally.  We'll probably need similar condition
>    for ATAPI devices too if we support FIS-based PM switching.

Main reason is that it will largely only have benefits on ATAPI devices, 
and I've only tested it on ATAPI devices.


> 2. I'm a bit skeptical whether this change will bring any noticeable
>    performance improvement.  OTOH, this seems to be a good source for

Agreed.


>    obscure problems on some controllers which might not implement/test
>    this feature properly.  As more controllers implement AHCI spec,
>    the possibility grows.

Agreed.


> Anyways, here's the patch regenerated against #upstream.

Could I trouble you for a resend, with a proper signed-off-by and patch 
description?

	Jeff



