Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUIAU1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUIAU1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIAUYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:24:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:46825 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267696AbUIAUQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:16:53 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Charbonnel <thomas@undata.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <1094069473.7477.2.camel@twins>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu>
	 <20040901135122.GA18708@elte.hu>  <1094058546.6465.2.camel@localhost>
	 <1094069473.7477.2.camel@twins>
Content-Type: text/plain
Message-Id: <1094069815.1970.52.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 16:16:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 16:11, Peter Zijlstra wrote:
> On Wed, 2004-09-01 at 19:09 +0200, Thomas Charbonnel wrote:
> > Ingo Molnar wrote :
> > > i've released the -Q7 patch:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7
> > 
> > With Q7 I still get rx latency issues (> 130 us non-preemptible section
> > from rtl8139_poll). Moreover network connections were extremely slow
> > (almost hung) until I set /proc/sys/net/core/netdev_backlog_granularity
> > to 2.
> > 
> > Thomas
> > 
> 
> Me too!
> I too have a rtl8139 network card.
> 
> kr, what kind of nic do you have since this does not occur on your
> machine?

Hmm, I am not a network driver expert, and this is just a guess, but if
they work anything like sound cards, I would say that that that hardware
will only generate an interrupt when there are 2 packets in its queue.

Lee

