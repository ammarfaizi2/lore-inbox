Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUJULgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUJULgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270682AbUJULar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:30:47 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26019
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270477AbUJUL0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:26:14 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jens Axboe <axboe@suse.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <20041021111116.GE10531@suse.de>
References: <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu>
	 <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
	 <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de>
	 <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de>
	 <1098353505.26758.38.camel@thomas>  <20041021111116.GE10531@suse.de>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098357486.26758.48.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 13:18:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 13:11, Jens Axboe wrote:
> > 
> > IMHO, this is not clearly seperated and therefor produces a lot of
> > confusion.
> 
> Semaphore and mutex has always been the same thing in Linux. Apparently
> this isn't so in Ingos tree, you should make a clear distinction on
> which you are discussing.

I agree, but this thread is discussing Ingo's tree :)

I know that semaphores and mutexes are the same, but that's something
which should be seperated IMHO. 

Ingo's changes reviel a couple of places where completion or wait_event
is more clean, than using a mutex. That's all I'm talking about. Sorry,
if I did not express it clearly enough or even used a wrong expression. 

The points, which we identify are not wrong from the view point when
they were coded. They use a mutex to wait for completion, which is
functional by the mutex implementation and common use in the kernel.

Part of this discussion is the given mixup in the kernel, which is
functionally correct, but if a mutex is changed to a real mutex then it
is wrong in the semantical sense.

tglx



