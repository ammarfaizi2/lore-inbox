Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290687AbSBFR2Y>; Wed, 6 Feb 2002 12:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290688AbSBFR2P>; Wed, 6 Feb 2002 12:28:15 -0500
Received: from ns.caldera.de ([212.34.180.1]:62609 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290687AbSBFR2D>;
	Wed, 6 Feb 2002 12:28:03 -0500
Date: Wed, 6 Feb 2002 18:27:46 +0100
Message-Id: <200202061727.g16HRkG12893@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: dipankar@in.ibm.com (Dipankar Sarma)
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Ingo's smptimers patch experiment
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20020206211925.A8720@in.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020206211925.A8720@in.ibm.com> you wrote:
> Hi Ingo,
>
> I ported your smptimers patch to 2.5.3 and experimented with 
> it a little bit. Basically I am curious about why we
> we need to call run_all_timers() (which runs timers for all
> CPUs) through the timer bh if locking fails in run_local_timers(). 

Some driver do ugly things with TIMER_BH, and Ingo's 2.4 patched
tried to stayed source compatible with 2.4 drivers.

For 2.5 I'd really like to see TIMER_BH (all BH's in fact) to gone.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
