Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270743AbUJUU4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270743AbUJUU4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270824AbUJUUxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:53:13 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:25092 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S270809AbUJUUuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:50:04 -0400
Date: Thu, 21 Oct 2004 13:49:39 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Jens Axboe <axboe@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021204939.GA25190@nietzsche.lynx.com>
References: <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021203821.GA24628@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 01:38:21PM -0700, Bill Huey wrote:
> On Thu, Oct 21, 2004 at 10:33:50PM +0200, Jens Axboe wrote:
> > Linux semaphores (being counted) have always been a fine fit for things
> > like the loop use, where you get to down it 10 times because you have 10
> > items pending. I know this isn't the traditional mutex and that it
> > doesn't protect data as such, but is was never abuse. It isn't overload.
> > Doing it with a traditional mutex (I'm assuming this is what mutex_t is
> > in Ingos tree) would be overload and a bad idea, indeed.
> 
> Well, this is something that's got to be considered by the larger Linux
> community and whether these conventions are to be kept or removed. It's
> a larger issue than what can be address in Ingo's preemption patch, but
> with inevitable need for something like this in the kernel (hard RT)
> it's really unavoidable collision. IMO, it's got to go, which is a nasty
> change.

But this is a non-fatal case. I'll see if I can change this logic to not
completely die when this case is detected.

bill

