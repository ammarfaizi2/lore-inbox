Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSGOI4q>; Mon, 15 Jul 2002 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSGOI4p>; Mon, 15 Jul 2002 04:56:45 -0400
Received: from CPE00608c86a77d.cpe.net.cable.rogers.com ([24.157.76.7]:33540
	"EHLO mielke.cc") by vger.kernel.org with ESMTP id <S317395AbSGOI4o>;
	Mon, 15 Jul 2002 04:56:44 -0400
Date: Mon, 15 Jul 2002 04:58:05 -0400 (EDT)
From: Dave Mielke <dave@mielke.cc>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <agtlq6$iht$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0207150446070.1071-100000@dave.private.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Linus Torvalds on July 15, 2002, at 05:15]

>The fact that the kernel internally counts at some different rate should
>be _totally_ invisible to user programs (except they get better latency
>for stuff like select() and other timeouts).

I believe your position to be right on. May I ask, however, about a quandry
which we have in BRLTTY? We generate short "tunes" via the PC speaker in order
to give a blind user audible clues regarding certain events. To do this, we
need rather precise control over how long each note is on. Due to the current
lack of granularity, we need to do some rather long busy loops. This has worked
out okay, but it'd of course be much better if we could rely on the kernel to
do it, especially on a busy system, if its granularity is good enough. My
quandry is that while I don't believe that user land should know what
granularity the kernel is using, I'd still like to know if we should busy loop
or let the kernel do it depending on whether or not the kernel's granularity is
good enough for our needs. It'd be nice to have a way, therefore, to query two
values at run time, i.e. the granularity that services like select can offer
and the maximum amount of time that nanosleep will do a very accurate short
wait, although I suppose that these abilities could be abused by some.

-- 
Dave Mielke           | 2213 Fox Crescent | I believe that the Bible is the
Phone: 1-613-726-0014 | Ottawa, Ontario   | Word of God. Please contact me
EMail: dave@mielke.cc | Canada  K2A 1H7   | if you're concerned about Hell.
http://familyradio.com

