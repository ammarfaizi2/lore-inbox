Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSEGQDR>; Tue, 7 May 2002 12:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315872AbSEGQDQ>; Tue, 7 May 2002 12:03:16 -0400
Received: from Expansa.sns.it ([192.167.206.189]:10759 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S315870AbSEGQDO>;
	Tue, 7 May 2002 12:03:14 -0400
Date: Tue, 7 May 2002 18:02:39 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andy Carlson <naclos@andyc.dyndns.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
In-Reply-To: <20020507170331.P31998@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0205071746120.15110-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Andrea Arcangeli wrote:

>
> If Marcelo accepts my patches, I will be very glad to replace khttpd
> with tux into mainline 2.4. The two products are completly equivalent
> and risking to increase the khttpd userbase just because tux isn't in
> mainline doesn't make any sense to me, it can only waste resources.
> (despite it makes much more sense to use zope, apache, servlets and php
> instead of tux for anything real, first of all for security reasons, but
> that's another issue, here the issue is khttpd vs tux and this one is a
> no brainer)
>
Yes, functionally khttpd and TuX are more or less equivalent, but khttpd
does not depend on any user space command, it is fully
configurable via procfs. If I do remember well when you showed me TuX
at SNS, it had to be managed trought some command line.

If khttpd bugs can be fixed, there is no real reason to replace it with
TuX.

On the other side to merge TuX together with khttpd could seem a bad
replication, unnecessary for cleanness. What could be the really important
point is how well khttpd and TuX are maintained. TuX semms to be activelly
maintained, while khttpd maintainer was a little absent in recent past, it
seems...



What was surprising me is that I use khttpd since a lot of time, and while
I saw some of the secundary bugs reported here, it was stable for server
user on my servers, and they can be very stressed, and khttpd is very
usefull with high loads, expecially with sparc linux.
Probably that is
because I do not change khttpd configuration on the fly (I use from 2 to 8
threads depending on how many CPUs I have).

So I tested the patch posted here, and it worked (well the addons to the
README are quite important, but I am using even longer sleeps ;), due to
experience I had with khttpd, but that is not a real bug )

About the security reasons, you are not complitelly wrong nor complitelly
right. khttpd use apache or whatelse web server for everything is not a
static page, and for every static page that has not the correct
permissions. I tried a lot of time to crash it with high loads, but nope
even on a gigabit ethernet, all I could get is a 403 message.
Maybe on PCs it behaves differently...



