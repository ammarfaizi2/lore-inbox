Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTALWUd>; Sun, 12 Jan 2003 17:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbTALWUd>; Sun, 12 Jan 2003 17:20:33 -0500
Received: from mail.zmailer.org ([62.240.94.4]:27078 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267566AbTALWTg>;
	Sun, 12 Jan 2003 17:19:36 -0500
Date: Mon, 13 Jan 2003 00:28:23 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rob Wilkens <robw@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030112222823.GR27709@mea-ext.zmailer.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:27:30PM -0500, Rob Wilkens wrote:
> > Explain how you can do that cleanly, understandably, and without
> > code duplication, or ugly kludges  without using those goto ?
> > (And sticking to coding-style.)
> 
> I've only compiled (and haven't tested this code), but it should be much
> faster than the original code.  Why?  Because we're eliminating an extra
> "jump" in several places in the code every time open would be called. 

Benchmark them - original and your revised.   (Their equivalents, that is,
in userspace with rdtscll() ) 

Put them into a test-harness calling them million times (or some such).
Look also what assembly the compiler produced, e.g. that it didn't optimize
away error paths.

> Yes, it's more code, so the kernel is a little bigger, but it should be
> faster at the same time, and memory should be less of an issue nowadays.

That is common fallacy.  Learn to code in environments where you
have to account for every byte of code and ram usage, and your code
will be fast even in bigger systems.

> Here's the patch if you want to apply it (i have only compile tested it,
> I haven't booted with it).. This patch applied to the 2.5.56 kernel.
....

/Matti Aarnio
