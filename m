Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUJaN2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUJaN2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 08:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUJaN2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 08:28:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:409 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261622AbUJaN2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 08:28:17 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 15:28:06 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031152806.058a19da@mango.fruits.de>
In-Reply-To: <20041031132237.GB23437@elte.hu>
References: <20041030214738.1918ea1d@mango.fruits.de>
	<1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
	<20041030233849.498fbb0f@mango.fruits.de>
	<20041031120721.GA19450@elte.hu>
	<20041031124828.GA22008@elte.hu>
	<20041031151130.675cb012@mango.fruits.de>
	<20041031132237.GB23437@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 14:22:37 +0100
Ingo Molnar <mingo@elte.hu> wrote:


> cool! May i have a feature request :-) It would be quite useful to have
> an option to see the jitter output in percentage and in microseconds as
> well. I.e. an option to have such a format:
> 
>  late wakeup: +151.3 usecs (14.6%) jitter.

yep, will do so ater trying the 0.6.1 kernel.

> cycles are too large to be human readable, and absolute values are
> harder to read when HZ is not 1024. So to get a 'quick feel' of the
> delays in a system the above line would be the most informative (for me
> that is). Also, the percentage can go back to %.1f i think, instead of
> %.5f or so - it's good to have a decimal point in the percentage but one
> number after it is more than enough.) The more compact the output, the
> fewer useless info, the quicker the human brain can read it. (Obviously
> to generate a nice graph out of it needs a different format.)

well, to generate graphs out of the data one can choose to write the raw
cycle counts into a "history file". Then one can process this raw data to
hearts content. i will update the output routines to truncate the percentage
to %.1f [or the c++ equivalent :)]

> 
> > Here's a typical run (still on V0.5.16, will try V0.6 now):
> 
> please try -V0.6.1, -V0.6 had a pretty stupid bug that could trigger
> frequently.
> 
> > threshold violations: 20
> > max jitter:           58.1228%
> 
> here it would also be useful to have the 'max jitter' in usecs. I.e. in
> the above case it was somewhere around ~570 usecs.

ack.

flo
