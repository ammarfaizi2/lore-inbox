Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030491AbWHIFra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030491AbWHIFra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWHIFra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:47:30 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37960 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965075AbWHIFr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:47:29 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=C23uuMajBeFPpvJkAgNud2gLm7zlV8lOQoiuadgNIZtS5wz+63se9W2cPbBSWtRma
	oo6ljY9ZRYlIr70pB4nNw==
Message-ID: <44D976E6.5010106@google.com>
Date: Tue, 08 Aug 2006 22:47:18 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: tgraf@suug.ch, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193345.1396.16773.sendpatchset@lappy>	<20060808211731.GR14627@postel.suug.ch>	<44D93BB3.5070507@google.com> <20060808.183920.41636471.davem@davemloft.net>
In-Reply-To: <20060808.183920.41636471.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Daniel Phillips <phillips@google.com>
  >>Can you please characterize the conditions under which skb->dev changes
>>after the alloc?  Are there writings on this subtlety?
> 
> The packet scheduler and classifier can redirect packets to different
> devices, and can the netfilter layer.
> 
> The setting of skb->dev is wholly transient and you cannot rely upon
> it to be the same as when you set it on allocation.
>
> Even simple things like the bonding device change skb->dev on every
> receive.

Thankyou, this is easily fixed.

> I think you need to study the networking stack a little more before
> you continue to play in this delicate area :-)

The VM deadlock is also delicate.  Perhaps we can work together.

Regards,

Daniel
