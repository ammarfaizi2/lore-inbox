Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273132AbRIRSXZ>; Tue, 18 Sep 2001 14:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273136AbRIRSXF>; Tue, 18 Sep 2001 14:23:05 -0400
Received: from mailg.telia.com ([194.22.194.26]:10456 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S273132AbRIRSWz>;
	Tue, 18 Sep 2001 14:22:55 -0400
Message-Id: <200109181822.f8IIMv618968@mailg.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
Date: Tue, 18 Sep 2001 20:18:10 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net> <1000530869.32365.21.camel@phantasy> <20010918040550Z273827-761+10122@vger.kernel.org>
In-Reply-To: <20010918040550Z273827-761+10122@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday den 18 September 2001 06:06, Dieter Nützel wrote:
> Yes, but no crash or oops for me.
> "Only" some "stalls" during MPEG/Ogg-Vorbis playback (2-5 sec) :-(

> > > But I get some hiccup during noatun (mp3, ogg, etc. player for KDE-2.2)
> > > or plaympeg together with dbench (16, 32). ReiserFS needs some
> > > preemption fixes, too?
> >
> > You may still get some small hiccups ( < 1 second?) even with the
> > preemption patch, as kernel locks prevent preemption (the patch can't
> > guarentee low latency, just preemption outside of the locks).
>
> Sadly 2-5 seconds at the beginning of dbench and during bonnie++ block
> operations (huge IO pressure, ~20% system, 3-5% user, 116308 kilobytes
> paged out).
>
> > However, how bad was the hiccups with preemption disabled?  I have heard
> > reports where it is 3-5sec at times.
>
> Yes, nearly the same.
>

Do you run with the playback process reniced -N?
It should really run with a low SCHED_FIFO or SCHED_RT policy.
But renicing it with a negative value gives some of the benefits...
(but you need to run as root)
In addition to this the program might need to lock its pages down - the
only thing I can think of that could cause several seconds delay would
be if it has been swapped out...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
