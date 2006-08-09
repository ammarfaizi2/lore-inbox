Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWHIBgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWHIBgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWHIBgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:36:05 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60906 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030402AbWHIBgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:36:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=R4StrJQqD6HUyJGX+QX7Tv1rdleIky0wgg4eoq/6DHcDERRSsmvhvend3WBs0i5fB
	M+SMS30odGk2N4ngJKzcA==
Message-ID: <44D93BEE.4000001@google.com>
Date: Tue, 08 Aug 2006 18:35:42 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808193325.1396.58813.sendpatchset@lappy>	<20060808193345.1396.16773.sendpatchset@lappy> <20060808.151020.94555184.davem@davemloft.net>
In-Reply-To: <20060808.151020.94555184.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

David Miller wrote:
> I think the new atomic operation that will seemingly occur on every
> device SKB free is unacceptable.

Alternate suggestion?

> You also cannot modify netdev->flags in the lockless manner in which
> you do, it must be done with the appropriate locking, such as holding
> the RTNL semaphore.

Thanks for the catch.

Regards,

Daniel



