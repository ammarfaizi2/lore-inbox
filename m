Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270301AbTGRSbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270292AbTGRSbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:31:21 -0400
Received: from pop.gmx.net ([213.165.64.20]:42171 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270302AbTGRSbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:31:11 -0400
Message-Id: <5.2.1.1.2.20030718202746.01af5828@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 20:49:45 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Wiktor Wodecki <wodecki@gmx.net>, Nick Piggin <piggin@cyberone.com.au>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:52 AM 7/18/2003 -0700, Davide Libenzi wrote:
>On Fri, 18 Jul 2003, Mike Galbraith wrote:
>
> > Telling to not mess with my kernel threads seems to have fixed it here...
> > no stalls during the whole contest run.  New contest numbers attached.
>
>It is ok to use unfairness towards kernel threads to avoid starvation. We
>control them. It is right to apply uncontrolled unfairness to userspace
>tasks though.

In this case, it appears that the lowered priority was causing 
trouble.  One test run isn't enough to say 100%, but what I read out of the 
numbers is that at least kswapd needs to be able to preempt.

wrt the uncontrolled unfairness, I've muttered about this before.  I've 
also tried (quite) a few things, but nothing yet has been good enough to... 
require trashing that I couldn't do here ;-)

         -Mike 

