Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270373AbUJUKnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbUJUKnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJUKmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:42:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270653AbUJUKiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:38:54 -0400
Date: Thu, 21 Oct 2004 12:34:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021103454.GD10531@suse.de>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021101821.GB473@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021101821.GB473@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21 2004, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > I didn't look at the USB code, I'm just saying that it's perfectly
> > valid use of a semaphore the pattern you describe (process A holding
> > it, process B releasing it).
> 
> yes, that is perfectly true, and sorry if we gave you the wrong
> impression.
> 
> the goal of these patches is to do a semaphore->completion conversion in
> cases where the semaphore was used for completion purposes. It's a bit
> faster and more readable but not a 'bugfix' in any way. (another set of
> patches are converting sleep_on() uses to wait_event*() plus waitqueues
> - those can in fact be considered bugfixes in some cases.)
> 
> typically the cases where semaphores are held by one task and released
> by another task happens coincide with this used-for-completion scenario.

Thanks for the explanation, I can agree with that.

-- 
Jens Axboe

