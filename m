Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269211AbUHZQsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269211AbUHZQsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269201AbUHZQqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:46:24 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:13233 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S269145AbUHZQjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:39:46 -0400
Date: Thu, 26 Aug 2004 12:38:13 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       nando@ccrma.stanford.edu
Subject: Re: [patch] PPC/PPC64 port of voluntary preempt patch
Message-ID: <20040826163813.GA14963@yoda.timesys>
References: <20040823221816.GA31671@yoda.timesys> <20040824195122.GA9949@yoda.timesys> <1093490252.5678.56.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093490252.5678.56.camel@krustophenia.net>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:17:32PM -0400, Lee Revell wrote:
> I think Scott may be on to something.  There are several reports that P9
> does not work on SMP machines at all - it either doesn't boot, locks up
> the first time there is heavy IRQ activity (starting KDE), or locks up
> as soon as the first RT process is run.  This is exactly the behavior
> that would be expected if Scott is correct.  See this thread:
> 
> http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-August/005899.html
> 
> Does anyone have P9 working on SMP?  Fernando, can you see if M5 works
> on SMP?  If this works it would seem that the preemptible IRQs are the
> problem.

It worked for me on an SMP G5, but it would depend on which drivers
are used; some use synchronize_irq() more than others.

IIRC, though, M5 didn't have the IO-APIC fixes, so that's not likely
to work well on SMP either.

-Scott
