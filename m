Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCTWlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCTWlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVCTWlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:41:05 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:29907 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261317AbVCTWkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:40:16 -0500
Date: Sun, 20 Mar 2005 14:40:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
Message-ID: <20050320224009.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <1111282389.15947.2.camel@mindpipe> <423CD6E0.2000806@cybsft.com> <1111293179.16453.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111293179.16453.7.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 11:32:59PM -0500, Lee Revell wrote:
> On Sat, 2005-03-19 at 19:50 -0600, K.R. Foley wrote:
> > Lee Revell wrote:
> > > On Sat, 2005-03-19 at 20:16 +0100, Ingo Molnar wrote:
> > > 
> > >>the biggest change in this patch is the merge of Paul E. McKenney's
> > >>preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
> > >>is still quite experimental at this stage, it allowed the removal of
> > >>locking cruft (mainly in the networking code), so it could solve some of
> > >>the longstanding netfilter/networking deadlocks/crashes reported by a
> > >>number of people. Be careful nevertheless.
> > > 
> > > 
> > > With PREEMPT_RT my machine deadlocked within 20 minutes of boot.
> > > "apt-get dist-upgrade" seemed to trigger the crash.  I did not see any
> > > Oops unfortunately.
> > > 
> > > Lee
> > > 
> > 
> > Lee,
> > 
> > Just curious. Is this with UP or SMP? I currently have my UP box running 
> >   PREEMPT_RT, with no problems thus far. However, my SMP box dies while 
> > booting (with an oops). I am working on trying to get setup to capture 
> > the oops, although it might be tomorrow before I get that done.
> > 
> 
> UP.  It's 100% reproducible, this machine locks up over and over.  Seems
> to be associated with network activity by multiple processes.

OK, guess I need to go inspect the uses of synchronize_net() in addition
to synchronize_kernel...

If you do manage to get any additional info, please let me know...

						Thanx, Paul
