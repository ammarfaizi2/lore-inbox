Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSGIFIU>; Tue, 9 Jul 2002 01:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSGIFIT>; Tue, 9 Jul 2002 01:08:19 -0400
Received: from ns1.intercarve.net ([216.254.127.221]:10297 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S317304AbSGIFIT>; Tue, 9 Jul 2002 01:08:19 -0400
Date: Tue, 9 Jul 2002 00:49:08 -0400 (EDT)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal 
In-Reply-To: <200207090146.g691kD429646@eng4.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0207090037320.13295-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    If nothing else, I hope you will think twice before sending off
>    your next BKL removel patch in a subsystem that you haven't fully
>    tested or understood.  That's the point I keep trying to get across
>    here.
>
>So can you define for me under what conditions the BKL is appropriate
>to use?  Removing it from legitimate uses would be bad, of course, but
>part of the problem here is that it's currently used for a variety of
>unrelated purposes.


If the trade-offs weigh in about the same, removing the BKL from
legitimate uses in favor of a different (neither better nor worse)
approach would be more than acceptable, would it not?

Would creating a few new names for lock_kernel() and friends be
acceptable? Just a few macros to give slightly more meaningful names to
each function call for 2.5. Then take lock_kernel() entirely away (the
name, not the function), in 2.7. By 2.9 it should be able to be removed
from nearly all "inappropriate" uses. This seems like it would encourage
more  explicit usage of the BKL, while giving maintainers ample time to
comply.

Note that I have never added or removed a lock from the kernel. I am
simply thinking aloud; half hoping to be corrected.

--Drew Vogel

