Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270279AbTGNPIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270268AbTGNPIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:08:10 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:27035 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270293AbTGNPCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:02:25 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 08:09:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy   ...
In-Reply-To: <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307140805220.4371@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net> <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Mike Galbraith wrote:

> At 12:12 AM 7/14/2003 -0700, Davide Libenzi wrote:
> >On Mon, 14 Jul 2003, Mike Galbraith wrote:
> > > While testing, I spotted something pretty strange.  It's not specific to
> > > SCHED_SOFTRR, SCHED_RR causes it too.  If I fire up xmms's gl visualization
> > > with either policy, X stops getting enough sleep credit to stay at a usable
> > > priority even when cpu usage is low.  Fully repeatable weirdness.  See
> > > attached top snapshots.
> >
> >RT tasks are pretty powerfull and should not be used to run everything ;)
> >What I was seeking with this patch was 1) deterministic latency 2) stave
> >protection.
>
> Yes, I know.  I only fired up the cpu hog as a test to see that the
> protection would kick in.  I did do that too though, ran _everything_...
> the whole X/KDE beast SCHED_SOFTRR for grins :)
>
> I should have reported the strangeness in a different thread, it has
> nothing to do with your patch.

Did you try the skip resistance test by running XMMS alone with audio ?
Also, trying the whole player running with SOFTRR does not match the
effective use MM apps will do of it. Usually inside MM apps the data
decoder (that might suck CPU) lives in another thread and the thread that
is actually responsible for timings simply fetch the prepared data.



- Davide

