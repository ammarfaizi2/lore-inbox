Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTGZSVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTGZSUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:20:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:55704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267378AbTGZSU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:20:26 -0400
Date: Sat, 26 Jul 2003 11:35:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-Id: <20030726113522.447578d8.akpm@osdl.org>
In-Reply-To: <200307271046.30318.phillips@arcor.de>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
	<20030726101015.GA3922@eugeneteo.net>
	<3F2264DF.7060306@wmich.edu>
	<200307271046.30318.phillips@arcor.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> wrote:
>
> Audio players fall into a special category of application, the kind where it's 
>  not unreasonable to change the code around to take advantage of new kernel 
>  features to make them work better.

One shouldn't even need to modify the player application to start using a
new scheduler policy - policy is inherited, so a wrapper will suffice:

	sudo /bin/run-something-as-softrr mplayer

> Remember this word: audiophile.

That is one problem space, and I guess if we fix that, we fix the X11
problems too.

Let us not lose sight of the other problem: particular sleep/run patterns
as demonstrated in irman are causing extremem starvation.  Arguably we
should be addressing this as the higher priority problem.


It is interesting that Felipe says that stock 2.5.69 was the best CPU
scheduler of the 2.5 series.  Do others agree with that?


And what about the O(1) backports?  RH and UL and -aa kernels?  Are people
complaining about those kernels?  If not, why?  What is different?

