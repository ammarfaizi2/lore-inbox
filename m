Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbULMAKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbULMAKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 19:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbULMAKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 19:10:10 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:7134 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262115AbULMAKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 19:10:03 -0500
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234256.GK6272@elf.ucw.cz>
Message-ID: <cone.1102896588.31702.10669.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <kernel@kolivas.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Date: Mon, 13 Dec 2004 11:09:48 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

> Hi!
> 
>> >The overhead is a single l1 cacheline in the paths manipulating HZ
>> >(rather than having an immediate value hardcoded in the asm, it reads it
>> >from a memory location not in the icache). Plus there are some
>> >conversion routines in the USER_HZ usages. It's not a measurable
>> >difference.
>> 
>> Just being devils advocate here...
>> 
>> I had variable Hz in my tree for a while and found there was one 
>> solitary purpose to setting Hz to 100; to silence cheap capacitors.
>> 
>> The rest of my users that were setting Hz to 100 for so-called 
>> performance gains were doing so under the false impression that cpu 
>> usage was lower simply because of the woefully inaccurate cpu usage 
>> calcuation at 100Hz.
>> 
>> The performance benefit, if any, is often lost in noise during 
>> benchmarks and when there, is less than 1%. So I was wondering if you 
>> had some specific advantage in mind for this patch? Is there some 
>> arch-specific advantage? I can certainly envision disadvantages to lower Hz.
> 
> Actually, I measured about 1W power savings with HZ=100. That's about
> as much as spindown of disk saves...

How does the popular proprietary operating system cope with this? My 
understanding is they run 1000Hz yet they have good power saving and quiet 
capacitors. Presumably they do a lot less per timer tick?

Cheers,
Con

