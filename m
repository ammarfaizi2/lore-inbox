Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUKCBPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUKCBPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKCBP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:15:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57503 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261277AbUKCBOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:14:07 -0500
Date: Wed, 3 Nov 2004 02:15:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: mark_h_johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.9
Message-ID: <20041103011511.GB16884@elte.hu>
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com> <20041102191858.GB1216@elte.hu> <20041102192709.GA1674@elte.hu> <32932.192.168.1.8.1099437703.squirrel@192.168.1.8> <32796.192.168.1.5.1099442372.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32796.192.168.1.5.1099442372.squirrel@192.168.1.5>
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

> Rui Nuno Capela wrote:
> >
> > I am also rehearsing these same tests on my P4/SMT desktop.
> > I'll post those a bit later today.
> >
> 
> So here they are. This machine is a P4 2.80C@3.366GHz, HT enabled on a
> Asus P4P800 mobo, Intel 82801EB onboard sound device (snd-intel8x0).
> 
>                                    2.6.9smp   RT-V0.6.9smp
>                                  ------------ ------------
>  XRUN Rate   . . . . . . . . . :       0            0      /hour
>  Delay Rate (>spare time)  . . :       0            0      /hour
>  Delay Rate (>1000 usecs)  . . :       0            0      /hour
>  Delay Maximum . . . . . . . . :     346          166      usecs
>  Cycle Maximum . . . . . . . . :     986         1028      usecs
>  Average DSP Load. . . . . . . :      25.0         25.7    %
>  Average Interrupt Rate  . . . :    1717         1718      /sec
>  Average Context-Switch Rate . :   10082        15793      /sec
> 
> As you can see, the results here aren't so disparate as on my UP
> laptop.

i suspect it has to do with the different load - the UP laptop had 40%
utilization, this box is 25% utilized.

> I guess that I can stress this out and lower the period size on jackd
> -R, to -p64. And even increase the workload with more client instances
> (from 9 to 18 ?) to let the RT show it's potential, if that makes
> sense at all.

yeah, it would really be nice to see how much it can take and to see the
point where the -RT kernel starts to suffer from xruns too.

	Ingo
