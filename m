Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270829AbUJUU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270829AbUJUU0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbUJUUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:21:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26076 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270928AbUJUUSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:18:54 -0400
Date: Thu, 21 Oct 2004 22:14:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021201443.GF32465@suse.de>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021195842.GA23864@nietzsche.lynx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21 2004, Bill Huey wrote:
> On Thu, Oct 21, 2004 at 12:11:03PM +0200, Jens Axboe wrote:
> > I didn't look at the USB code, I'm just saying that it's perfectly valid
> > use of a semaphore the pattern you describe (process A holding it,
> > process B releasing it).
> 
> A lot of things are perfectly "valid" in the Linux kernel regarding
> stuff like that are a bit irregular. But the preemption work about
> to stress these things in ways that was never designed to which is
> why these patches are needed. Having a clear use of various locking
> conventions is key to getting this system to behave in a predictable
> manner. Quite simply, Linux was never targetted to do this and the
> sloppiness is showing so it's got to be removed.

I have to disagree, I don't think the above use is either convoluted or
sloppy in any way. Now that we have the completion structure, certain
things are surely better implemented as such. But the old use is
perfectly valid and logical, imho.

-- 
Jens Axboe

