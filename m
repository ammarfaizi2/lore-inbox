Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUJWTOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUJWTOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUJWTOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:14:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14044 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261279AbUJWTOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:14:37 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
In-Reply-To: <20041023185132.GA1268@us.ibm.com>
References: <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
	 <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>
	 <20041022175633.GA1864@elte.hu>  <20041023185132.GA1268@us.ibm.com>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 15:14:35 -0400
Message-Id: <1098558876.13176.54.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 11:51 -0700, Paul E. McKenney wrote:
> On Fri, Oct 22, 2004 at 07:56:33PM +0200, Ingo Molnar wrote:
> > 
> > i have released the -U10.2 Real-Time Preemption patch, which can be
> > downloaded from:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> 
> On realtime-preempt-2.6.9-mm1-U10.3:
> 
> o	In rcupdate.h, I believe that the:
> 
> 	+# define rcu_read_unlock_nort()                rcu_read_lock_nort()
> 
> 	should instead be:
> 
> 	+# define rcu_read_unlock_nort()                rcu_read_unlock()
> 

Oh no!  That would explain a lot... the typical report is it works fine
until people go to use the network :-P

Lee

