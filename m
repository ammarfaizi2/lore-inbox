Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268719AbUJPNDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268719AbUJPNDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 09:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbUJPNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 09:03:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32953 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268719AbUJPNDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 09:03:32 -0400
Date: Sat, 16 Oct 2004 15:04:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016130450.GA8387@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <32812.192.168.1.5.1097922568.squirrel@192.168.1.5> <41711A08.7040905@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41711A08.7040905@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >>It builds fine if CONFIG_SMP is set.  Am I really the only person
> >>running this on UP?
> >
> >I run both, on different machines.
> >
> >I'm actually running 2.6.9-rc4-mm1-U3 at this very moment, on my laptop
> >(P4 2.53Ghz/UP, Mdk 10.1c) and also on my desktop machine (P4
> >2.80Ghz/SMP/HT, SuSE 9.1).
> >
> >However, on the desktop (SMP/HT) I could only made it boot/init
> >successfully with CONFIG_PREEMPT_REALTIME off. On my laptop (UP) is
> >running pretty well on full RT.
> 
> I'm curious what you get when you try to boot the SMP system with
> REALTIME on? My SMP/HT system at the office works fine with this. 
> Although there is one difference that jumps out at me. I have disabled
> ACPI. I don't have the config handy so I can't do a complete
> comparison, just going from memory.

one group of complaints seems to be related to SELINUX=y: it has hooks
all across the kernel deep within the locking hierarchy - and then
itself it does pretty complex stuff too. IPC is certainly broken due to
this, but some networking problems seem to be related too.

	Ingo
