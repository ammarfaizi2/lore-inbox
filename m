Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVJCO6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVJCO6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVJCO6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:58:36 -0400
Received: from quark.didntduck.org ([69.55.226.66]:15240 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750971AbVJCO6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:58:35 -0400
Message-ID: <4341476A.80809@didntduck.org>
Date: Mon, 03 Oct 2005 10:59:54 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <paul.mundt@nokia.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
References: <20051003143634.GA1702@nokia.com>
In-Reply-To: <20051003143634.GA1702@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> The downside to this is that some people may be expecting that
> pre-allocated elements are used as reserve space for when regular
> allocations aren't possible. In which case, this would break that
> behaviour.

This is the original intent of the mempool.  There must be objects in 
reserve so that the machine doesn't deadlock on critical allocations 
(ie. disk writes) under memory pressure.

--
				Brian Gerst
