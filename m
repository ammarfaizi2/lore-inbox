Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276285AbRJGKv3>; Sun, 7 Oct 2001 06:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbRJGKvT>; Sun, 7 Oct 2001 06:51:19 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:24841 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S276234AbRJGKvE>;
	Sun, 7 Oct 2001 06:51:04 -0400
From: "Rob Turk" <r.turk@chello.nl>
Subject: Re: AIC7xxx panic
Date: Sun, 7 Oct 2001 12:48:28 +0200
Organization: Cistron Internet Services B.V.
Message-ID: <9ppc3l$cde$1@ncc1701.cistron.net>
In-Reply-To: <1002451051.3718.20.camel@warblade>
X-Trace: ncc1701.cistron.net 1002451894 12718 213.46.44.164 (7 Oct 2001 10:51:34 GMT)
X-Complaints-To: abuse@cistron.nl
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <noth@noth.is.eleet.ca> wrote in message
news:cistron.1002451051.3718.20.camel@warblade...
> I got a reproducible panic while running dbench simulating 25+ clients,
> the new aic7xxx driver panics with "Too few segs for dma mapping.
> "Increase AHC_NSEG". The partition in question is FAT32 and on a
> different disk than /, I'm not using HIGHMEM. I am using XFS and the
> preempt patches, but I don't think they're related to the panic.
>
> The odd thing, is if I run dbench in the same manner on my / partition,
> which is on a different disk on the same controller, it goes fine. It
> seems, to my untrained eye anyway, to be a bad interaction between the
> vfat driver and the aic7xxx driver.
>
> I'm using the old aic7xxx driver right now and it's fine, has anyone
> else seen anything like this?
>
> Jim

Since this seems to fail on just one disk, it might have to do with one of the
disk characteristics, like command queue depth. Did you enable Tagged Command
Queueing, and if so, can you try playing around with the maximum depth?

Rob




