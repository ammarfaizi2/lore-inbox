Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269016AbTGUANZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbTGUANZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:13:25 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:38555 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S269016AbTGUANY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:13:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Jul 2003 17:21:20 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity 
In-Reply-To: <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307201715130.3548@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org> <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net> <5.2.1.1.2.20030719184847.01ad4ce8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003, Mike Galbraith wrote:

> >Everything that will make the scheduler to say "ok, I gave enough time to
> >interactive tasks, now I'm really going to spin one from the masses" will
> >work. Having a clean solution would not be an option here.
>
> ... just as soon as I get my decidedly unclean work-around functioning at
> least as well as it did for plain old irman.   irman2 is _much_ more evil
> than irman ever was (wow, good job!).  I thought it'd be a half an hour
> tops.  This little bugger shows active starvation, expired starvation,
> priority inflation, _and_ interactive starvation (i have to keep inventing
> new terms to describe things i see.. jeez this is a good testcase).

Yes, the problem is not only the expired tasks starvation. Anything in
the active array that reside underneath the lower priority value of the
range irman2 tasks oscillate inbetween, will experience a "CPU time eclipse".
And you do not even need a smoked glass to look at it :)



- Davide

