Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbTALVGp>; Sun, 12 Jan 2003 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbTALVGo>; Sun, 12 Jan 2003 16:06:44 -0500
Received: from mail.zmailer.org ([62.240.94.4]:8646 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267518AbTALVGn>;
	Sun, 12 Jan 2003 16:06:43 -0500
Date: Sun, 12 Jan 2003 23:15:30 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rob Wilkens <robw@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112211530.GP27709@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 02:34:54PM -0500, Rob Wilkens wrote:
> Linus,
> 
> I'm REALLY opposed to the use of the word "goto" in any code where it's
> not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> to comment

Bob,

At first, read   Documentation/CodingStyle   of the kernel.
Then have a look into:

    fs/open.c  file    do_sys_truncate()  function.

Explain how you can do that cleanly, understandably, and without
code duplication, or ugly kludges  without using those goto ?
(And sticking to coding-style.)

Also take into account, that there the most common execution path
is direct, and exceptions are redirected elsewere.


Original "gotos are evil" comes from days of FORTRAN (and BASIC)
coding, where labels were all numeric, and definitely non-descriptive.
Where nested conditionals didn't exist, etc. Source-code nesting didn't
exist either...


Doing things in moderation will usually produce better code,
than strict sticking into some paradigm or other.


Of course in schools there is definite need for severe whaking of
sense into heads of the young would-be coders.  Clean reusable
and maintainable code is _hard_ to produce without any sort of
role-models and rules, especially when kids teach coding for
themselves by looking into other kids code of "look how clever
spaghetti I made" stuff.

When you learn the ropes (rules), and code enough (some years),
you will finally learn where you can relax the rules a bit.
Especially where the rules _must_ be altered to allow some
formerly boo-boo styles.


...
> If I'm misinterpreting the original code, then forgive me..  I just saw
> a goto and gasped.  There's always a better option than goto.

Yes there are, but we are coding in C, nor C++ or Java...

> -Rob

/Matti Aarnio
