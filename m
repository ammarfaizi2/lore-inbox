Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268845AbUJUJws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268845AbUJUJws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268860AbUJUJwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:52:20 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:63753 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270493AbUJUJr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:47:28 -0400
Date: Thu, 21 Oct 2004 10:47:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021094726.GA2652@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Rui Nuno Capela <rncbc@rncbc.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
	"K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
	Adam Heath <doogie@debian.org>,
	Florian Schmidt <mista.tapas@gmx.net>,
	Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
	Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021093532.GA2482@infradead.org> <20041021094438.GA30986@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021094438.GA30986@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 11:44:38AM +0200, Ingo Molnar wrote:
> 
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > The problem is that semaphores are hold by Process A and released by
> > > Process B, which makes Ingo's checks trigger
> > 
> > Which is perfectly valid for a semaphore.
> 
> yes, it is valid and perfectly fine code, but i'm trying to separate out
> the simple 'mutex' functionality (99% of the semaphore users are just
> that) and implement a 'counted semaphore' separately. This removes a
> number of implementational constraints from mutexes.

So leave the good old struct semaphore alone and introduce a mutex_t..

