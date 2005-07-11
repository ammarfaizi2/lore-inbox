Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVGKPGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVGKPGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGKPES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:04:18 -0400
Received: from quark.didntduck.org ([69.55.226.66]:18395 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261882AbVGKPCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:02:11 -0400
Message-ID: <42D28A27.9000507@didntduck.org>
Date: Mon, 11 Jul 2005 11:03:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel> <p73eka614t7.fsf@verdi.suse.de> <Pine.LNX.4.61.0507110718500.16055@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0507110718500.16055@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 11 Jul 2005, Andi Kleen wrote:
> 
> 
>>Why per node? Why not go the whole way and make it per CPU?
>>
>>I would also not define it statically, but allocate it at boot time
>>in node local memory.
> 
> 
> I went per node so that it would be minimal/zero impact for the no-node 
> case, it would also simplify hotplug cpu since once a cpu in a node goes 
> down, we still have other participating processors capable of handling 
> its devices without having to do too much migration work. I'll definitely 
> incorporate the node local allocations however, for some i386 systems we 
> might be forced to stick some additional IDTs on node 0 since the IDTR 
> will only take 32bit addresses and we could end up with only highmem on 
> some nodes.

Doesn't the IDTR take a virtual address?  It has to or else the f00f bug 
fix wouldn't work.

--
				Brian Gerst
