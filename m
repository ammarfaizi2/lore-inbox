Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUIIU53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUIIU53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUIIUyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:54:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11442 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266137AbUIIUxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:53:00 -0400
Date: Thu, 9 Sep 2004 22:51:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com,
       scott@timesys.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040909205141.GA8968@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu> <1094758399.1362.268.camel@krustophenia.net> <1094762629.1362.320.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094762629.1362.320.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > I believe Scott Wood suggested a fix back when I first reported this,
> > have to check my mailbox.  Scott?
> 
> Nope, checking the original thread, Scott pointed out that any RT
> process will have mlockall'ed anyway and thus won't be affected by
> this latency.  So, this one would be cool to fix, but it's not a
> problem as such.

RT threads will be affected by this latency just as much because it's a
non-preemptable critical section. You are right in that an RT task wont
see the overhead itself because it doesnt generate swap entries.

	Ingo
