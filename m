Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSKRHeR>; Mon, 18 Nov 2002 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSKRHeR>; Mon, 18 Nov 2002 02:34:17 -0500
Received: from mail.gmx.de ([213.165.65.60]:49974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261595AbSKRHeQ>;
	Mon, 18 Nov 2002 02:34:16 -0500
Message-ID: <002e01c28ed5$21f6dd00$6400a8c0@mikeg>
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Andrew Morton" <akpm@digeo.com>,
       "Tim Connors" <tconnors@astro.swin.edu.au>
Cc: <linux-kernel@vger.kernel.org>
References: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de> <slrn-0.9.7.4-16621-21084-200211181750-j.$random.luser@swin.edu.au> <3DD891D6.93E8E5E4@digeo.com>
Subject: Re: 2.5.47 scheduler problems?
Date: Mon, 18 Nov 2002 08:35:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Andrew Morton" <akpm@digeo.com>
To: "Tim Connors" <tconnors@astro.swin.edu.au>
Cc: <linux-kernel@vger.kernel.org>; "Mike Galbraith" <efault@gmx.de>
Sent: Monday, November 18, 2002 8:08 AM
Subject: Re: 2.5.47 scheduler problems?


> Tim Connors wrote:
> >
> > > I used to be able to wave a window poorly at make -j25 (swapping
heftily),
> > > fairly smoothly at make -j20, and smoothly at make -j15 or below.
This
> > > with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like
this in
> > > quite a while though)
> >
> > Perhaps you should consider buying an extra 29 CPU's for you
desktop?
> >
>
> No.  He's saying that it used to be OK, but it has got worse.
>
> A much simpler test is to start a big compilation and then madly
> waggle an X window around.  Goes OK for a few seconds, and then
> seizes up quite horridly.  Presumably because the scheduler has
> suddenly decided that the X server has become a "batch" process
> and is scheduling it in a similar manner to the compilation.
>
> If you stop wiggling the window for 5-10 seconds it comes back.
> Presumably because the scheduler has decided that the X server is
> "interactive" again.
>
> When it happens, it's *very* bad.  The mouse cursor doesn't move
> for 0.5-1.0 seconds and then takes great leaps.  It is unusable.

I was watching it this morning, without wiggling, and it seems to update
window content (make output in one and vmstat in another) about every 5
seconds.. very odd looking.

    -Mike

