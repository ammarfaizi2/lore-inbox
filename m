Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVBGJXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVBGJXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVBGJXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:23:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56536 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261377AbVBGJXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:23:19 -0500
Date: Mon, 7 Feb 2005 10:22:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
Message-ID: <20050207092228.GB19189@elte.hu>
References: <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <20050201201402.GA31930@elte.hu> <1107481908.27584.448.camel@localhost.localdomain> <1107483490.27584.459.camel@localhost.localdomain> <1107583350.27584.473.camel@localhost.localdomain> <20050205075936.GA22103@elte.hu> <1107613964.27584.481.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107613964.27584.481.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 2005-02-05 at 08:59 +0100, Ingo Molnar wrote:
> 
> > hm - i had a fix in this area in the -V0.7 series. Then i thought this
> > is a performance fix only and dropped it eventually, but could you give
> > it a go - does it fix the deadlock?
> > 
> > 	Ingo
> 
> Yep, it worked! I tried a similar fix earlier but I put the preempt
> disable before the setting of q->status (duh!) and it didn't work. But
> it was late and I was tired of looking at it.  I was about to say that
> I already tried it, but then noticed the placement of preempt_disable,
> and thought, I better try yours anyway. Well, it seems to fix it. By
> the way, I just put in the disable and enable in -37. I haven't gotten
> to your 38 yet, but this fixed 37.

good - i've merged this into the -38-03 release.

	Ingo
