Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWCRJmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWCRJmO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWCRJmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:42:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:668 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932355AbWCRJmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:42:12 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <200603181915.48098.kernel@kolivas.org>
References: <1142658480.8262.38.camel@homer>
	 <20060318000549.4bb35800.akpm@osdl.org>
	 <200603181915.48098.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 10:43:56 +0100
Message-Id: <1142675036.9000.3.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 19:15 +1100, Con Kolivas wrote:
> On Saturday 18 March 2006 19:05, Andrew Morton wrote:
> > Mike Galbraith <efault@gmx.de> wrote:
> > > The patch below fixes a starvation problem that occurs when a stream of
> > >  highly interactive tasks delay an array switch for extended periods
> > >  despite EXPIRED_STARVING(rq) being true.  AFAIKT, the only choice is to
> > >  enqueue awakening tasks on the expired array in this case.
> > >
> > >  Without this patch, it can be nearly impossible to remotely login to a
> > >  busy server, and interactive shell commands can starve for minutes.
> > >
> > >  This has not been verified by anyone.  Comments?
> >
> > What does that question mean, btw?
> 
> He's waiting for me to say I don't like it. But I do like it.

<chuckle>

No.  Actually, I'm waiting for Ingo to just yawn and nuke the problem
with a casual flick of his pinkie.

	-Mike

