Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWGFU2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWGFU2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWGFU2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:28:33 -0400
Received: from zrtps0kn.nortel.com ([47.140.192.55]:5521 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750795AbWGFU2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:28:32 -0400
Message-ID: <44AD725F.6070005@nortel.com>
Date: Thu, 06 Jul 2006 14:28:15 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <1152187268.3084.29.camel@laptopd505.fenrus.org> <44AD5357.4000100@rtr.ca> <Pine.LNX.4.64.0607061213560.3869@g5.osdl.org> <44AD658A.5070005@nortel.com> <44AD666B.1060500@rtr.ca>
In-Reply-To: <44AD666B.1060500@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2006 20:28:19.0483 (UTC) FILETIME=[B80F66B0:01C6A13A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Chris Friesen wrote:
> 
>>
>> The "reordered" thing really only matters on SMP machines, no?
> 
> 
> Also (very much!) for device drivers.

Certainly...but I was coming at it from the perspective of userspace code.

As long as you're not talking to external devices, each cpu must be 
coherent with respect to itself, no?  It's allowed to execute 
out-of-order, but it needs to make sure that by doing so it doesn't 
cause changes that are visible to software.

Chris
