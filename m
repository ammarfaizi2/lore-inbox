Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbTJ1Wrm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTJ1Wrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:47:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:34543 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261791AbTJ1Wrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:47:39 -0500
Message-ID: <3F9EF206.1040105@mvista.com>
Date: Tue, 28 Oct 2003 14:47:34 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jim Houston <jim.houston@ccur.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
References: <1066678923.1007.164.camel@new.localdomain> <20031024135112.GE2286@wotan.suse.de>
In-Reply-To: <20031024135112.GE2286@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Oct 20, 2003 at 03:42:03PM -0400, Jim Houston wrote:
> 
>>Hi Andi,
>>
>>I found your kgdb for x86_64 for linux-2.4.20 and I'm wondering if 
>>there is a version for the 2.6 tree?
>>
>>If it doesn't exist, I'm thinking of merging your changes with the
>>current i386 kgdb from Andrew Morton's tree.
> 
> 
> There is no 2.6 version of kgdb currently. The 2.4 version also has some
> problems that makes it better to not use it at all.
> 
> My plan was to do a fresh port from the code in -mm* and get rid of 
> many of the ugly hacks in 2.4. Doing this properly requires adding
> dwarf2 annotation to entry.S and other assembly files. This would
> allow to get rid of the "interrupt threads" hack in 2.4 because gdb
> could directly backtrace through exception/interrupts.

I see that Andrew has not picked up my latest kgdb.  In the latest version I 
have the dwarf2 stuff working in entry.S.  Just ask, off list.

-g
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

