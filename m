Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUBCDDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 22:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUBCDDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 22:03:18 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:738 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S265745AbUBCDDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 22:03:17 -0500
Message-ID: <401F0F5F.10306@cyberone.com.au>
Date: Tue, 03 Feb 2004 14:02:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040201151111.4a6b64c3.akpm@osdl.org>	<401D9154.9060903@cyberone.com.au> <87llnm482q.fsf@codematters.co.uk>	<401DDCD7.3010902@cyberone.com.au> <401E1131.6030608@cyberone.com.au>	<87d68xcoqi.fsf@codematters.co.uk> <401EDEF2.6090802@cyberone.com.au>	<20040202154959.283cf60b.akpm@osdl.org> <87isipvuvz.fsf@codematters.co.uk>
In-Reply-To: <87isipvuvz.fsf@codematters.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Philip Martin wrote:

>Andrew Morton <akpm@osdl.org> writes:
>
>
>>Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>>>Andrew, any other ideas?
>>>
>>There seems to be a lot more writeout happening.
>>
>
>As far as I can see (and hear!) that's true.
>
>
>>You could try setting /proc/sys/vm/dirty_ratio to 60 and
>>/proc/sys/vm/dirty_background_ratio to 40.
>>
>
>Not much different:
>
>2.6.1 (without elevator=deadline)
>
>dirty_ratio:60 dirty_background_ratio:40
>
>245.58user 121.82system 3:31.79elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
>0inputs+0outputs (0major+3771340minor)pagefaults 0swaps
>
>dirty_ratio:40 dirty_background_ratio:10  (the defaults)
>
>245.75user 121.33system 3:35.13elapsed 170%CPU (0avgtext+0avgdata 0maxresident)k
>0inputs+0outputs (0major+3770826minor)pagefaults 0swaps
>
>
>

OK now thats strange - you're definitely compiling the same kernel
with the same .config and compiler? 2.6 looks like its doing twice
the amount of writeout that 2.4 is.

Can you try the memory pressure program I sent you earlier?

