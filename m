Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267051AbUKAWeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267051AbUKAWeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUKAWeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:34:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31211 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S275634AbUKASsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:48:07 -0500
Date: Mon, 1 Nov 2004 19:48:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101184847.GC32009@elte.hu>
References: <OF45B54BA4.2C7A16BA-ON86256F3F.0059443C@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF45B54BA4.2C7A16BA-ON86256F3F.0059443C@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Did notice an odd message during the dump of tasks...
> Losing too many ticks!
> TSC cannot be used as a timesource.
> Possible reasons for this are:
>   You're running with Speedstep.   [almost surely not]
>   You don't have DMA enabled for your hard disk (see hdparm), [udma4 should
> be set at this point]
>   Incorrect TSC synchronization on an SMP system (see dmesg). [can't look
> at that, system is hung]
> Falling back to a sane timesource now.

this is just due to the messages going out to the serial console slowly
and with interrupts disabled. You can safely ignore this during the
dump, the system wont get into any much worse state from this. So it's a
pure side-effect.

	Ingo
