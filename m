Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUHYDWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUHYDWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUHYDWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:22:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62658 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268425AbUHYDWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:22:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412C04DB.9000508@cybsft.com>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>  <412C04DB.9000508@cybsft.com>
Content-Type: text/plain
Message-Id: <1093404161.5678.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 23:22:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 23:17, K.R. Foley wrote:
> Ingo Molnar wrote:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> > 

> latency trace of ~148 usec in scsi_request? I don't know if this is real 
> or not. Note the 79 usec here:
> 
> 00000001 0.107ms (+0.079ms): sd_init_command (scsi_prep_fn)
> 
> Entire trace is here:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace7.txt
> 
> 
> Is this possible? This is not the first time I have seen this. There is 
> another one here:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace5.txt
> 

This looks like a real latency.  What is
/sys/block/sdX/queue/max_sectors_kb set to?  Does lowering it help?

Lee

