Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUKPWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUKPWNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKPWFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:05:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41196 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261869AbUKPWEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:04:11 -0500
Date: Wed, 17 Nov 2004 00:05:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Dean Nelson <dcn@sgi.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041116230517.GB31529@elte.hu>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu> <20041116201841.GA29687@sgi.com> <20041116223608.GA27550@elte.hu> <419A78A5.1060800@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A78A5.1060800@nortelnetworks.com>
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


* Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Ingo Molnar wrote:
> >Using the linear priority has the
> >advantage of not having to pass any policy value - priorities between 0
> >and 99 implicitly mean SCHED_FIFO, priorities above that would mean
> >SCHED_NORMAL, a pretty natural and compact interface.
> 
> Just curious--why FIFO and not RR?

it shouldnt matter - if it matters, i.e. if any of these threads uses up
significant amount of CPU time then they should probably _not_ have a RT
priority to begin with.

	Ingo
