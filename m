Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271027AbUJUWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271027AbUJUWqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbUJUWcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:32:07 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:13528 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S271027AbUJUWag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:30:36 -0400
Date: Thu, 21 Oct 2004 18:30:03 -0400
To: john cooper <john.cooper@timesys.com>
Cc: Scott Wood <scott@timesys.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021223003.GA28704@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com> <20041021184742.GB26530@yoda.timesys> <41781984.5090602@timesys.com> <20041021211244.GA28290@yoda.timesys> <417834E4.7000506@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417834E4.7000506@timesys.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 06:15:00PM -0400, john cooper wrote:
> Yes, but my concern was having to backoff in out-of-sequence
> spinlock acquisition paths. 

Out-of-sequence acquisition is a bug, unless the caller uses trylocks
and handles backoff itself.

-Scott
