Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbUKVM11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUKVM11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUKVMZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:25:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:49034 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262085AbUKVMWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:22:38 -0500
Date: Mon, 22 Nov 2004 14:24:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122132459.GB19577@elte.hu>
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56781.195.245.190.93.1101119801.squirrel@195.245.190.93>
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

> > great. I now suspect that some of the xrun problems Rui was observing on
> > -RT kernel could be (positively) affected by these fixes too.
> >
> 
> Just made some test-runs with RT-V0.7.30-2, with my jackd-R +
> 8*fluidsynth benchmark on my laptop (P4/UP), and the results don't
> seem to be eligible to the hall of fame, at least when compared with
> RT-0.7.7 as the ones I last posted here a few weeks ago.
> 
> I hate to say this, but the XRUN rate has increased since RT-0.7.7,
> and the maximum scheduling delay reported by jackd has also degraded
> to 1000 usecs (was around 600 usecs).

well, life would be too easy if two bugs were fixed at once ;) These
were nodebug runs, right? Could you give me a description of the precise
commands of how you started jackd and fluidsyth (and their versions) -
so that i could try to reproduce & debug your setup. It is certainly a
complex scheduling scenario.

(perhaps with a link to the .sf2 and .mid files you used, if they are
public - or whether it's fine if i use the VintageDreamsWaves-v2.sf2
sound-fonts that comes with fluidsynth plus a random .mid file from the
net?)

> OTOH, there's another thing: I don't seem to be able to build an
> initrd image under the latest RT kernels. Something related to the
> loopback device. When trying to run mkinitrd it stalls, somewhere
> under this process:
> 
>   mount -t ext2 /root/tmp/initrd.img /root/tmp/initrd.mnt -o loop

Do you know when this started, roughly?

	Ingo
