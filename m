Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266702AbUGVQSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266702AbUGVQSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGVQSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:18:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1185 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266702AbUGVQSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:18:10 -0400
Date: Thu, 22 Jul 2004 18:19:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduling while atomic (Re: voluntary-preempt-2.6.8-rc2-H9)
Message-ID: <20040722161941.GA23972@elte.hu>
References: <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722160055.GA4837@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rudo Thomas <rudo@matfyz.cz> wrote:

> Hello there.
> 
> I finally managed to try out the voluntary preemption patch (H9 on
> 2.6.8-rc2).
> 
> The syslog got flooded by these

thx for the report - i fixed this in the -I0 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I0

(the problem only occured when CONFIG_PREEMPT was enabled.)

-I0 also fixes two more softirq latency sources: rt_run_flush() (this
one got reported previously) and cache_reap().

-I0 boots up fine with CONFIG_PREEMPT_VOLUNTARY & CONFIG_PREEMPT
enabled.

	Ingo
