Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUJTFFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUJTFFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUJTFFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:05:08 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:19605 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266193AbUJTFD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:03:56 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tXR/2C5sAslIHgy05dJDdf5pKBudxGpwoeFHDMv97u6NPKupBak5bKGhy2V5VIymppbyUCQbRJTxKSNUJFWFnpAdBYSsbdtK1X6imTTEU8pF2JUWI+XZ2PVaeHKpUR5T1HeCeWjXCT/1m518vD0kagN6yDshrRREMxJT1lpldhI
Message-ID: <7f800d9f04101922031be5cfe8@mail.gmail.com>
Date: Tue, 19 Oct 2004 22:03:55 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] cpufreq_ondemand
Cc: Alexander Clouter <alex-kernel@digriz.org.uk>,
       venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <4172F3C5.8090604@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041017222916.GA30841@inskipp.digriz.org.uk>
	 <4172F3C5.8090604@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 08:35:49 +1000, Con Kolivas <kernel@kolivas.org> wrote:
> I'd much prefer it shot up to 100% or else every time the cpu usage went
> up there'd be an obvious lag till the machine ran at it's capable speed.
>   I very much doubt the small amount of time it spent at 100% speed with
> the default design would decrease the battery life significantly as well.

I like Alexanders idea better and will give it a good try. If the
speed steps down slowly but shoots up 100% quickly (as it is right
now), even a small task (like opening a folder, or scrolling down in a
document) will cause a tiny spike to 100% which takes a while to go
back down. The result is that the CPU spends most of it's time at 100%
or calming down. I wrote a small test program on my notebook which
confirms this.

It's either or. Either you go up AND down slowly (which I would
prefer), or you go up and down immediately. But spiking up and slowly
going back down is not a good combo.

Alex has my vote, even so I have to give if some more testing.

Cheers,
    Andre
