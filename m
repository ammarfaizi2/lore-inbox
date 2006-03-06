Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWCFPME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWCFPME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWCFPME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:12:04 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:26898 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751333AbWCFPMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:12:02 -0500
Message-ID: <4547.195.245.190.94.1141657830.squirrel@www.rncbc.org>
In-Reply-To: <20060306132442.GA12359@elte.hu>
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org>
    <20060306132442.GA12359@elte.hu>
Date: Mon, 6 Mar 2006 15:10:30 -0000 (WET)
Subject: Re: realtime-preempt patch-2.6.15-rt18 issues
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 06 Mar 2006 15:11:48.0628 (UTC) FILETIME=[4A3B6540:01C64130]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

> Rui Nuno Capela wrote:
>
>>
>> ...
>> usb 2-1: USB disconnect, address 2 slab error in kmem_cache_destroy():
>> cache `scsi_cmd_cache': Can't free all objects
>
> hm, this implicates the SLAB code. I've uploaded -rt19, does it work any
> better [there i've included a newer version of the rt-SLAB code]? If you
> still get the same problem even under -rt19, do things improve if you
> enable CONFIG_EMBEDDED and CONFIG_SLOB?
>
> (-rt19 also has the tasklet/ALSA fix, and some other fixlets)
>

-rt19 doesn't compile here (either with CONFIG_EMBEDDED=y or not):

  ...
  CC      mm/slab.o
mm/slab.c:703: error: request for member 'lock' in something not a
structure or union
mm/slab.c:703: error: request for member 'lock' in something not a
structure or union
mm/slab.c:703: error: request for member 'lock' in something not a
structure or union
mm/slab.c:703: error: request for member 'lock' in something not a
structure or union
mm/slab.c:703: error: initializer element is not constant
mm/slab.c:703: error: (near initialization for 'cache_cache.spinlock')
make[1]: *** [mm/slab.o] Error 1
make: *** [mm] Error 2


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

