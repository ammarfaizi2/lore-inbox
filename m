Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUJ3TaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUJ3TaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUJ3TaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:30:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:40882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261257AbUJ3TaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:30:18 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 21:47:38 +0200
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
Message-ID: <20041030214738.1918ea1d@mango.fruits.de>
In-Reply-To: <20041030191725.GA29747@elte.hu>
References: <20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
	<1099086166.1468.4.camel@krustophenia.net>
	<20041029214602.GA15605@elte.hu>
	<1099091566.1461.8.camel@krustophenia.net>
	<20041030115808.GA29692@elte.hu>
	<1099158570.1972.5.camel@krustophenia.net>
	<20041030191725.GA29747@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 21:17:25 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > No, this cannot be the whole story, because unless verbose mode is
> > specified, jackd will only prints anything if there is an xrun.  So
> > there is something else going on.
> > 
> > This _really_ feels like a kernel bug.  Are you saying that this could
> > still be a jackd problem, even though T3 works perfectly with the
> > exact same jackd binary?
> 
> i think you are right - there are too many independent indicators
> pointing towards some sort of kernel problem. I'll try Florian's testapp
> and see whether i can see the 'window wiggle' problem.

Hi, in the meantime i also booted into P9 again and the results differ
dramatically. Much better in P9. Anyways, i reuploaded the tarball. The
program tries to detect missed irq's now and counts the total number of
irq's delivered by /dev/rtc. Since the program does not recover from missed
irq's the "statistical" data for these runs is useless [except for the
knowledge of the fact that one or more irq was missed :)]

flo
