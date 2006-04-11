Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWDKSnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWDKSnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDKSnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:43:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26773 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750872AbWDKSnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:43:24 -0400
Date: Tue, 11 Apr 2006 20:43:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same
 kernel
In-Reply-To: <5a4c581d0604111111s4946b39x3686ade1275ded90@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604112042060.25940@yvahk01.tjqt.qr>
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com> 
 <20060411122806.GA26836@rhlx01.fht-esslingen.de>
 <5a4c581d0604111111s4946b39x3686ade1275ded90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I'll be filing a FC5 performance bug for this but would like an opinion
>> >  from the IDE kernel people just in case this has already been seen...
>> >
>> > I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
>> >  and noticed a disk performance slowdown while copying files around.
>>
>> Just another suggestion: try eliminating/pinpointing I/O scheduler issues
>> (switch e.g. to "noop" at /sys/block/hda/queue/scheduler and compare again)
>
>Thanks Andi. Tried every scheduler (my default is anticipatory) and
> there aren't meaningful differences - 18.3 to 18.6MB/s.
>
>As a further data point, my box can burn a 8x DVD+R at up to 7.1x
> average speed under FC3, while it barely keeps up with 4x in FC5.

Since you said it happens with the same kernel, I think it's caused by 
userspace (do the boot-with-"-b" thing and you'll know). Possible someone 
setting DMA to speeds as low as udma4 or udma2.


Jan Engelhardt
-- 
