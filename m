Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272597AbTHEIYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHEIYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:24:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:21635 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272597AbTHEIX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:23:27 -0400
Message-Id: <5.2.1.1.2.20030805102719.01a06d48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 05 Aug 2003 10:27:30 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, mingo@elte.hu,
       felipe_alfaro@linuxmail.org
In-Reply-To: <200308051820.59266.kernel@kolivas.org>
References: <200308051012.12951.oliver@neukum.org>
 <200308050207.18096.kernel@kolivas.org>
 <200308051726.14501.kernel@kolivas.org>
 <200308051012.12951.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:20 PM 8/5/2003 +1000, Con Kolivas wrote:
>On Tue, 5 Aug 2003 18:12, Oliver Neukum wrote:
> > Am Dienstag, 5. August 2003 09:26 schrieb Con Kolivas:
> > > On Tue, 5 Aug 2003 16:03, Andrew Morton wrote:
> > > > We do prefer that TASK_UNINTERRUPTIBLE processes are woken promptly so
> > > > they can submit more IO and go back to sleep.  Remember that we are
> > > > artificially leaving the disk head idle in the expectation that the
> > > > task will submit more I/O.  It's pretty sad if the CPU scheduler leaves
> > > > the anticipated task in the doldrums for five milliseconds.
> > >
> > > Indeed that has been on my mind. This change doesn't affect how long it
> > > takes to wake up. It simply prevents tasks from getting full interactive
> > > status during the period they are doing unint. sleep.
> >
> > If you take that to its logical conclusion, such tasks should be woken
> > immediately. Likewise, the io scheduler should be notified when you know
> > that the task won't do io or will do other io, like waiting on character
> > devices, go paging out or terminate.
>
>Every experiment I've tried at putting tasks at the start of the queue 
>instead
>of the end has resulted in some form of starvation so should not be possible
>for any user task and I've abandoned it.

(ditto:) 

