Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWJYKcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWJYKcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423227AbWJYKcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:32:52 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:31404 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423223AbWJYKcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:32:52 -0400
Message-ID: <453F3D4E.4020608@de.ibm.com>
Date: Wed, 25 Oct 2006 12:32:46 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E9C18.70803@de.ibm.com> <20061025051238.GO4281@kernel.dk>
In-Reply-To: <20061025051238.GO4281@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>> Thanks! Also note that you do not need to log every event, just register
>>> a mask of interesting ones to decrease the output logging rate. We could
>>> so with some better setup for that though, but at least you should be
>>> able to filter out some unwanted events.
>> ...and consequently try to scale down relay buffers, reducing the risk of
>> memory constraints caused by blktrace activation.
> 
> Pretty pointless, unless you are tracing lots of disks. 4x128kb gone
> wont be a showstopper for anyone.

per (online) CPU and device?

>>>> However, a fast network connection plus a second system for blktrace
>>>> data processing are serious requirements. Think of servers secured
>>>> by firewalls. Reading some counters in debugfs, sysfs or whatever
>>>> might be more appropriate for some one who has noticed an unexpected
>>>> I/O slowdown and needs directions for further investigation.
>>> It's hard to make something that will suit everybody. Maintaining some
>>> counters in sysfs is of course less expensive when your POV is cpu
>>> cycles.
>> Counters are also cheaper with regard to memory consumption. Counters
>> are probably cause less side effects, but are less flexible than
>> full-blown traces.
> 
> And the counters are special cases and extremely inflexible.

Well, I disagree with "extremely".
These statistics have attributes that allow users to adjust data
aggregation, e.g. to retain more detail in a histogram by adding
buckets.

