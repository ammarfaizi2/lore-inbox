Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbULIMrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbULIMrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 07:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULIMra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 07:47:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47300 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261516AbULIMrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 07:47:18 -0500
Date: Thu, 9 Dec 2004 13:46:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dean Nelson <dcn@sgi.com>
Cc: chrisw@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] export sched_setscheduler() for kernel module use
Message-ID: <20041209124653.GA28578@elte.hu>
References: <4198F70D.mailxMSZ11J00J@aqua.americas.sgi.com> <20041115105801.T14339@build.pdx.osdl.net> <20041115203343.GA32173@sgi.com> <20041116104821.GA31395@elte.hu> <20041116201841.GA29687@sgi.com> <20041116223608.GA27550@elte.hu> <20041208203426.GA6370@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208203426.GA6370@sgi.com>
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


* Dean Nelson <dcn@sgi.com> wrote:

> > another potential API would be to use the linear priority range that the
> > scheduler has internally, from 0 (RT prio 99) to 140 (nice +19). I'm not
> > sure which solution is the better one. Using the linear priority has the
> > advantage of not having to pass any policy value - priorities between 0
> > and 99 implicitly mean SCHED_FIFO, priorities above that would mean
> > SCHED_NORMAL, a pretty natural and compact interface.
> 
> I realize that I don't know where you are ultimately headed with your
> ideas for scheduling changes, but as things are it doesn't make sense
> to me to drop the SCHED_RR scheduling policy. There may be existing
> users who depend on the preemptive nature of this policy. It seems too
> much of a risk to eliminate this policy at this time.

agreed ... that's the weak point. Oh well. So this leaves your original
patch. If someone wants to change the nice value it can be done
separately. I.e. roughly the same API for kernelspace as for userspace.

	Ingo
