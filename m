Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRDPXwK>; Mon, 16 Apr 2001 19:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132421AbRDPXvv>; Mon, 16 Apr 2001 19:51:51 -0400
Received: from chmls06.mediaone.net ([24.147.1.144]:65419 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S132419AbRDPXvr>; Mon, 16 Apr 2001 19:51:47 -0400
Message-ID: <001801c0c6d1$0528d340$6501a8c0@gonar.com>
From: "Mark Salisbury" <gonar@mediaone.net>
To: "george anzinger" <george@mvista.com>, "Mark Salisbury" <mbs@mc.com>
Cc: "Jamie Lokier" <lk@tantalophile.demon.co.uk>,
        "Ben Greear" <greearb@candelatech.com>,
        "Horst von Brand" <vonbrand@sleipnir.valparaiso.cl>,
        <linux-kernel@vger.kernel.org>,
        <high-res-timers-discourse@lists.sourceforge.net>
In-Reply-To: <200104131205.f3DC5KV11393@sleipnir.valparaiso.cl> <3ADA60C6.1593A2BF@candelatech.com> <20010416044630.A18776@pcep-jamie.cern.ch> <0104160841431V.01893@pc-eng24.mc.com> <3ADB45C0.E3F32257@mvista.com>
Subject: Re: No 100 HZ timer!
Date: Mon, 16 Apr 2001 19:57:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Given a system speed, there is a repeating timer rate which will consume
> 100% of the system in handling the timer interrupts.  An attempt will
> be made to detect this rate and adjust the timer to prevent system
> lockup.  This adjustment will look like timer overruns to the user
> (i.e. we will take a percent of the interrupts and record the untaken
> interrupts as overruns)

just at first blush, there are some things in general but I need to read
this again and more closely....

but, with POSIX timers, there is a nifty little restriction/protection built
into the spec regarding the re-insertion of short interval repeating timers.
that is: a repeating timer will not be re-inserted until AFTER the
associated signal handler has been handled.

this has some interesting consequences for signal handling and signal
delivery implementations, but importantly, it ensures that even a flood of
POSIX timers with very short repeat intervals will be handled cleanly.

I will get more detailed comments to you tomorrow.

Mark Salisbury

