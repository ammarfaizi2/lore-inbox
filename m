Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270027AbUJTKsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270027AbUJTKsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJTKnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:43:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51841 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267683AbUJTKiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:38:46 -0400
Date: Wed, 20 Oct 2004 12:40:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020104005.GA1813@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041020100424.GA32396@elte.hu> <11742.195.245.190.93.1098268363.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11742.195.245.190.93.1098268363.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Ingo Molnar wrote:
> >
> >> Changes since -U7:
> >>
> >
> > - fix block-loopback assert reported by Mark H Johnson, Matthew L
> >   Foster and Rui Nuno Capela. (usually triggers during 'make install'
> >   of a kernel compile.)
> >
> 
> Is this fix already on U8 ? I don't seem to get out of mkinitrd (which
> is triggered by kernel make install).

please re-download -U8, i've updated it a couple of minutes after
uploading it, but apparently not fast enough :-| Sorry!

> OTOH, still on my laptop (P4/UP) I'm getting this very often:
> 
> RTNL: assertion failed at net/ipv4/devinet.c (1049)

yeah - this too was an oversight i fixed in the latest upload.

> ------------[ cut here ]------------
> kernel BUG at lib/rwsem-generic.c:598!

>  [<c0104b0d>] error_code+0x2d/0x38 (100)
>  [<e003f9c8>] loop_thread+0x61/0x11b [loop] (32)
>  [<c0102305>] kernel_thread_helper+0x5/0xb (722608148)

yes, this is the loopback fix. Please-retry with the latest patch.

	Ingo
