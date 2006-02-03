Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWBCWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWBCWlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWBCWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:41:00 -0500
Received: from rtr.ca ([64.26.128.89]:24557 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750816AbWBCWk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:40:59 -0500
Message-ID: <43E3DB99.9020604@rtr.ca>
Date: Fri, 03 Feb 2006 17:39:21 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at> <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>
> This sort of testing reminds me of Linus's 100->1000 Hz change
> ("I chose 1000 originally partly as a way to make sure that people that
>     assumed HZ was 100 would get a swift kick in the pants.")
> 
> Could we also do that with VMSPLIT?
> ("Let's choose VMSPLIT_2G to make sure that i386-people that assumed
> PAGE_OFFSET was 0xC0000000 would get...")

Mmm.. bad idea.  As much as I'd like the default to be 3GB_OPT, that would
be a big impact to userspace, and there's no point in breaking everyone's
machines when advanced users can just reconfig/recompile to get what they want.

>> Hm, I wonder if we could have a more fine-grained choice of the
>> boundary? There are also systems around with e.g. 1.25G or 1.5G of
>> main memory.
>>
> Maybe something like:
>         config VMSPLIT_1G
>                 bool "1G/3G user/kernel split"
>         config VMSPLIT_X
>                 bool "Manual split"
> endchoice
...

Yes, that looks like a good idea.

Cheers
