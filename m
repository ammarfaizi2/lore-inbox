Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270129AbTGNPrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbTGNPrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:47:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49813 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270129AbTGNPrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:47:13 -0400
Message-Id: <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 14 Jul 2003 18:06:19 +0200
To: Davide Libenzi <davidel@xmailserver.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  
  ...
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0307140805220.4371@bigblue.dev.mcafeelabs.co
 m>
References: <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:09 AM 7/14/2003 -0700, Davide Libenzi wrote:
>On Mon, 14 Jul 2003, Mike Galbraith wrote:
>
> > At 12:12 AM 7/14/2003 -0700, Davide Libenzi wrote:
> > >On Mon, 14 Jul 2003, Mike Galbraith wrote:
> > > > While testing, I spotted something pretty strange.  It's not 
> specific to
> > > > SCHED_SOFTRR, SCHED_RR causes it too.  If I fire up xmms's gl 
> visualization
> > > > with either policy, X stops getting enough sleep credit to stay at 
> a usable
> > > > priority even when cpu usage is low.  Fully repeatable weirdness.  See
> > > > attached top snapshots.
> > >
> > >RT tasks are pretty powerfull and should not be used to run everything ;)
> > >What I was seeking with this patch was 1) deterministic latency 2) stave
> > >protection.
> >
> > Yes, I know.  I only fired up the cpu hog as a test to see that the
> > protection would kick in.  I did do that too though, ran _everything_...
> > the whole X/KDE beast SCHED_SOFTRR for grins :)
> >
> > I should have reported the strangeness in a different thread, it has
> > nothing to do with your patch.
>
>Did you try the skip resistance test by running XMMS alone with audio ?

Yes, and it worked fine.  No cpu load I tossed at it caused a skip.

         -Mike 

