Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLZWbO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 17:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTLZWbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 17:31:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27886 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264339AbTLZWbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 17:31:08 -0500
Message-ID: <3FECB657.1090306@mvista.com>
Date: Fri, 26 Dec 2003 14:29:43 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       dilinger@voxel.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
References: <1072229780.5300.69.camel@spiral.internal> <20031223182817.0bd3dd3c.akpm@osdl.org> <3FE8FC2E.3080701@pobox.com> <20031223184827.4cfb87e2.akpm@osdl.org> <3FE9022A.7010604@pobox.com> <20031223202305.489c409f.akpm@osdl.org> <20031224043349.GI18208@waste.org> <3FEAB1D6.9030209@mvista.com> <20031225123637.GK18208@waste.org>
In-Reply-To: <20031225123637.GK18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Thu, Dec 25, 2003 at 01:45:58AM -0800, George Anzinger wrote:
> 
>>By the way, in my looking at the network link stuff, I started wondering if 
>>it could not be done without modifying the card stuff.  Here is what I see:
>>
>>The poll routine just calls the interrupt handler.  We only need the 
>>address of that routine and a generic poll function to do the indirect 
>>call.  That address, once the link is up, can be found in the interrupt 
>>tables using the irq.
> 
> 
> Netpoll did exactly this in an earlier incarnation, but Jeff
> eventually convinced me it was problematic.
> 
I suppose :(  But it would make driver modification go away.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

