Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWEURZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWEURZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWEURZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 13:25:15 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24007 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964903AbWEURZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 13:25:13 -0400
Date: Sun, 21 May 2006 13:24:51 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Knecht <markknecht@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>
Subject: Re: 2.6.16-rt22/23 kernels hanging after registering IO schedulers
In-Reply-To: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0605211321400.28717@gandalf.stny.rr.com>
References: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2006, Mark Knecht wrote:

> Hi Ingo and others,
>    It's been quite awhile since I wrote anything here. I have been
> using the 2.6.15-rt kernels for audio work on my AMD64 machine, but I
> haven't written much music lately so the work load has been very low.
> Actually I've found that for light work the standard Gentoo 2.6.16
> kernel without -rt patches has been good enough for my real-time needs
> of late so thanks to all the kernel developers for those more results
> also.
>
>    Working quite nicely on my system are:
>
> 2.6.15-rt18

Well this is good to hear.

> 2.6.16-gentoo-r2
>
>    Some Gentoo oriented folks created a new 'pro-audio' overlay which
> allows Gentoo users to build both applications and -rt kernels using
> normal portage methods. Here's the link:
>
> http://proaudio.tuxfamily.org/wiki/index.php?title=Main_Page

Also interesting to know.

>
>    Since the newest -rt kernels are part of the overlay I thought I'd
> give building and booting one a try. At the time the version in the
> overlay was 2.6.16-rt22 so I tried that. Unfortunately the boot
> process hangs immediately after some messages about registering IO
> schedulers.
>
>    My method to build 2.6.16-rt22 was to emerge the source from the
> pro-audio overlay, copy the 2.6.15-rt18 .config file, run make
> oldconfig, make menuconfig, make && make modules_install, and then
> copy the kernel source to /boot.
>
>    My method to build 2.6.16-rt23 was to download linux-2.6.16, unzip
> and untar, patch it with the -rt23 patch from your site, then again
> use the 2.6.15-rt18 .config file as in the previous paragraph. Same
> results.
>
>    I did try changing the default IO Scheduler, as well as leaving a
> few out. I still hang at the same place.
>
>    My guess is that it's the step immediately after registering these
> schedulers that's hanging but I no longer have a second computer so I
> cannot do the console thing with the serial cable. Sorry.
>
>    Again, no serious problems for me since both 2.6.15-rt18 &
> 2.6.16-gentoo-r2 are working great, but I thought I should at least
> report this to see if there is some known thing I need to change or,
> if not, make sure you are aware of the problem.
>
>    Here's some very basic info about the hardware
>

OK, there's been other reports of problems with booting AMD64 with the
latest -rt kernels.  I just got home from Germany, and will start testing
on my machine tomorrow.  I'll let you know what I find then.

-- Steve

