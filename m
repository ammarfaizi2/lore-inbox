Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVELQBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVELQBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVELQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:01:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33723 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262064AbVELQBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:01:21 -0400
Subject: Re: [RFC] (How to) Let idle CPUs sleep
From: Lee Revell <rlrevell@joe-job.com>
To: vatsa@in.ibm.com
Cc: Tony Lindgren <tony@atomide.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       schwidefsky@de.ibm.com, jdike@addtoit.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050512084650.GA20978@in.ibm.com>
References: <20050507182728.GA29592@in.ibm.com>
	 <1115524211.17482.23.camel@localhost.localdomain>
	 <427D921F.8070602@yahoo.com.au> <20050511180349.GG15479@atomide.com>
	 <20050512084650.GA20978@in.ibm.com>
Content-Type: text/plain
Date: Thu, 12 May 2005 12:01:19 -0400
Message-Id: <1115913679.20909.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 14:16 +0530, Srivatsa Vaddagiri wrote:
> On Wed, May 11, 2005 at 11:03:49AM -0700, Tony Lindgren wrote:
> > Sorry to jump in late. For embedded stuff we should be able to skip
> > ticks until something _really_ happens, like an interrupt.
> > 
> > So we need to be able to skip ticks several seconds at a time. Ticks
> > should be event driven. For embedded systems option B is really
> > the only way to go to take advantage of the power savings.
> 
> I don't know how sensitive embedded platforms are to load imbalance.
> If they are not sensitive, then we could let the max time idle
> cpus are allowed to sleep to be few seconds. That way, idle CPU
> wakes up once in 3 or 4 seconds to check for imbalance and still
> be able to save power for those 3/4 seconds that it sleeps.

Not very.  Embedded systems are usually UP so don't care at all.  If an
embedded system is SMP often it's because one CPU is dedicated to RT
tasks, and this model will become less common as RT preemption allows
you to do everything on a single processor.

Lee

