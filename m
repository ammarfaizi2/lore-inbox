Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUG2KDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUG2KDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUG2KDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 06:03:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:36356 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267428AbUG2KC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 06:02:56 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: ncunningham@linuxmail.org
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091061983.8867.95.camel@laptop.cunninghams>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
	 <1091054194.8867.26.camel@laptop.cunninghams>
	 <1091056916.1844.14.camel@teapot.felipe-alfaro.com>
	 <1091061983.8867.95.camel@laptop.cunninghams>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 12:02:21 +0200
Message-Id: <1091095341.4359.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 10:46 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2004-07-29 at 09:21, Felipe Alfaro Solana wrote:
> > kirdad? No... That sounds like Infrared which my laptop does not have.
> 
> Did to me too. I was clutching at straws. :>
> 
> > Here is a digest of ps -axf:
> > 
> >   PID TTY      STAT   TIME COMMAND
> >     1 ?        S      0:00 init [5]
> >     2 ?        S<     0:03 [irqd/0]
> >     3 ?        S<     0:00 [events/0]
> >     4 ?        S<     0:00  \_ [khelper]
> >     5 ?        S<     0:00  \_ [kacpid]
> >    22 ?        S<     0:00  \_ [kblockd/0]
> >    32 ?        S      0:00  \_ [pdflush]
> >    33 ?        S      0:00  \_ [pdflush]
> >    35 ?        S<     0:00  \_ [aio/0]
> >    36 ?        S<     0:00  \_ [xfslogd/0]
> >    37 ?        S<     0:00  \_ [xfsdatad/0]
> >    34 ?        S      0:00 [kswapd0]
> >    38 ?        S      0:00 [xfsbufd]
> >   120 ?        S      0:00 [kseriod]
> >   125 ?        S      0:00 [xfssyncd]
> >   273 ?        Ss     0:00 minilogd
> >   286 ?        S      0:00 [xfssyncd]
> >   287 ?        S      0:00 [xfssyncd]
> >   567 ?        S      0:00 [khubd]
> >   871 ?        S      0:00 [pccardd]
> >   877 ?        S      0:00 [pccardd]
> 
> It doesn't look like I've touched any of those threads. I have doubts
> about irqd/0 (is that kirqd reworked?), so you might try making setting
> PF_NOFREEZE and seeing if it makes a difference. I haven't done the
> switch to rc2-mm1 yet, so haven't gotten to those issues.

kirqd is voluntary-preempt patch by Ingo Molnar. I have also applied
several other patches, like Con's Staircase scheduler policy and some
latency fixes.

