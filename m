Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJLCV1>; Fri, 11 Oct 2002 22:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262720AbSJLCV1>; Fri, 11 Oct 2002 22:21:27 -0400
Received: from fastmail.fm ([209.61.183.86]:22167 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S262702AbSJLCV0>;
	Fri, 11 Oct 2002 22:21:26 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034389625
X-Sasl-enc: y7zgfTsPEFYn7WPwMHq51w
Message-ID: <0f4301c27196$af8a8880$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Jeremy Howard" <jhoward@fastmail.fm>
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sat, 12 Oct 2002 12:25:47 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Filesystem is ext3 with one big / partition (that's a mistake
> > we won't repeat, but too late now). This should be mounted
> > with data=journal given the kernel command line above, though
> > it's a bit hard to tell from the dmesg log:
> >
>
> It's possible tht the journal keeps on filling.  When that happens,
> everything has to wait for writeback into the main filesystem.
> Completion of that writeback frees up journal space and then everything
> can unblock.
>
> Suggest you try data=ordered.

We have a 192M journal, and from the dmesg log it's saying that it's got a 5
second flush interval, so I can't imagine that the journal is filling, but
we'll try it and see I guess.

What I don't understand is why the spike is so sudden, and decays so slowly.
It's Friday night now, so the load is fairly low. I setup a loop to dump
uptime information every 10 seconds and attached the result below. It's
running smoothly, then 'bam', it's hit with something big, which then slowly
decays off.

A few extra things:
1. It happens every couple of minutes or so, but not exactly on any time, so
it's not a cron job or anything
2. Viewing 'top', there are no extra processes obviously running when it
happens

Rob

