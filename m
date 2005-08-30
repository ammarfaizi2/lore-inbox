Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVH3Xy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVH3Xy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVH3Xy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:54:57 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:47035 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932269AbVH3Xy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:54:57 -0400
Message-ID: <4314F1C8.8040706@rtr.ca>
Date: Tue, 30 Aug 2005 19:54:48 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: add ATAPI module option
References: <20050830215234.GA6991@havoc.gtf.org>
In-Reply-To: <20050830215234.GA6991@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
> -#ifndef ATA_ENABLE_ATAPI
> -	if (unlikely(dev->class == ATA_DEV_ATAPI))
> -		return NULL;
> -#endif
> +	if (atapi_enabled) {
> +		if (unlikely(dev->class == ATA_DEV_ATAPI))
> +			return NULL;
> +	}
..

Is that if-stmt the right way around?
At first glance, I'd expect it to read:

      if (!atapi_enabled) {
      ...

Cheers!
