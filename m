Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270222AbUJSXs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbUJSXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270147AbUJSXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:47:52 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23970
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S270211AbUJSXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:47:29 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <1098229098.26927.40.camel@cmn37.stanford.edu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
	 <1098229098.26927.40.camel@cmn37.stanford.edu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098229166.12223.1153.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 01:39:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 01:38, Fernando Pablo Lopez-Lezcano wrote:
> On Tue, 2004-10-19 at 11:00, Ingo Molnar wrote:
> > i have released the -U7 Real-Time Preemption patch:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
> > 
> > this too is a fixes-only release.
> 

That's in scsi_error_handler() where a mutex is initialized locked and
then acquired again. This triggers the deadlock/correctness check.

tglx


