Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267710AbTAMBay>; Sun, 12 Jan 2003 20:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTAMBay>; Sun, 12 Jan 2003 20:30:54 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:11682 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S267710AbTAMBax>; Sun, 12 Jan 2003 20:30:53 -0500
Date: Sun, 12 Jan 2003 17:26:48 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Rob Wilkens <robw@optonline.net>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301121717140.30519-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've only compiled (and haven't tested this code), but it should be much
> faster than the original code.  Why?  Because we're eliminating an extra
> "jump" in several places in the code every time open would be called.
> Yes, it's more code, so the kernel is a little bigger, but it should be
> faster at the same time, and memory should be less of an issue nowadays.

Rob, one thing you may not have noticed since you haven't been following
the list for a while is that with the current generation of computers size
frequently translates directly into speed and a lot of the time honored
performance tricks that trade size for fewer commands executed end up
being losses.

this can be seen by compiling code with -O2 and with -Os and frequently
the -Os will actually be faster.

This is becouse not all memory is equal, main memory is very slow compared
to the CPU cache, so code that is slightly larger can cause more cache
misses and therefor be slower, even if significantly fewer commands are
executed.

in addition frequently the effect isn't direct (i.e. no noticable
difference on the code you are changing, but instead the change makes
other code slower as it gets evicted from the cache)

unfortunantly while this effect is known the rules of when to optimize for
space and when to optimize for fewer cpu cycles for code execution are not
clear and vary from CPU to CPU frequently within variations of the same
family)

if you google for -Os you should find one of the several discussions on
the list in the last year on the subject.

David Lang
