Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVCTEdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVCTEdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCTEdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:33:31 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:52673 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262022AbVCTEdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:33:08 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-00
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <423CD6E0.2000806@cybsft.com>
References: <20050319191658.GA5921@elte.hu>
	 <1111282389.15947.2.camel@mindpipe>  <423CD6E0.2000806@cybsft.com>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 23:32:59 -0500
Message-Id: <1111293179.16453.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 19:50 -0600, K.R. Foley wrote:
> Lee Revell wrote:
> > On Sat, 2005-03-19 at 20:16 +0100, Ingo Molnar wrote:
> > 
> >>the biggest change in this patch is the merge of Paul E. McKenney's
> >>preemptable RCU code. The new RCU code is active on PREEMPT_RT. While it
> >>is still quite experimental at this stage, it allowed the removal of
> >>locking cruft (mainly in the networking code), so it could solve some of
> >>the longstanding netfilter/networking deadlocks/crashes reported by a
> >>number of people. Be careful nevertheless.
> > 
> > 
> > With PREEMPT_RT my machine deadlocked within 20 minutes of boot.
> > "apt-get dist-upgrade" seemed to trigger the crash.  I did not see any
> > Oops unfortunately.
> > 
> > Lee
> > 
> 
> Lee,
> 
> Just curious. Is this with UP or SMP? I currently have my UP box running 
>   PREEMPT_RT, with no problems thus far. However, my SMP box dies while 
> booting (with an oops). I am working on trying to get setup to capture 
> the oops, although it might be tomorrow before I get that done.
> 

UP.  It's 100% reproducible, this machine locks up over and over.  Seems
to be associated with network activity by multiple processes.

Lee

