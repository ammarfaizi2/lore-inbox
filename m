Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUK0H0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUK0H0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 02:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUK0G7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:59:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32190 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261304AbUKZTHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:07:17 -0500
Date: Thu, 25 Nov 2004 12:44:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-0
Message-ID: <20041125114458.GA20831@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93> <20041125111344.GA17786@elte.hu> <4798.195.245.190.93.1101379116.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4798.195.245.190.93.1101379116.squirrel@195.245.190.93>
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

> > how hard of a freeze is it? I.e. if you log in over the text console,
> > and do:
> >
> > 	chrt -f 99 -p `pidof 'IRQ 1'`
> > 	chrt -f 99 -p $$
> >
> > can you access the sysrq keys after the freeze happens?
> 
> The lockup is pretty hard indeed. Complete lockup. No sysrq, not even
> any output thru serial console. The only action that has some visible
> effect is turning the power/reset switch off :)

note that unless you try the above, or the debug_direct_keyboard switch,
'soft' lockups will have the same symptoms: no sysrq, no serial console,
an apparently hung system. So unless you've done the equivalent already,
please try my suggestions.

	Ingo
