Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUKCT4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUKCT4R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUKCTzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:55:51 -0500
Received: from pop.gmx.net ([213.165.64.20]:9397 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261833AbUKCTvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:51:43 -0500
X-Authenticated: #4399952
Date: Wed, 3 Nov 2004 20:51:21 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041103205121.0184a9c7@mango.fruits.de>
In-Reply-To: <20041103123935.GA7865@elte.hu>
References: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com>
	<20041103083900.GA27211@elte.hu>
	<20041103084217.GA27404@elte.hu>
	<20041103100053.GA32680@elte.hu>
	<20041103123935.GA7865@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004 13:39:35 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> > > the patch below should fix this deadlock but there might be others
> > > around ...
> > 
> > the patch doesnt work. Working on a better solution.
> 
> this hopefully better solution is included in -V0.7.1.

Hi, 

i tried V0.7.7 and since all other RP kernels locked for me in X, i decided
to go to the console and try to see if i get some debugging output. Well i
put the usual stress on the system but besides some higher rtc_wakeup
jitters [up to 60%] which didn't show during the earlier runs that locked
when in X, the system ran fine. i wasn't able to lock the system from within
the console (X was started but idling at gdm).

Ok, so i suspected, maybe the locks i see got to do with X, so i changed to
the X console, logged in and quicklky switched back to the console. and no
surprise 10seconds later or so it locked (i suppose gnome was still loading
at that point in time). Without any console output. Does it matter which
virtual text console one is on? i thought not.

anyways. i might just get myself a serial console in a few days (old pc
froma buddy). but i thought a serial console would be mostly useful to
capture more of the debug messages. if none shows at all it won't help
either right?

flo
