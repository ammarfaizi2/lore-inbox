Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULAQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULAQIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULAQIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:08:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37544 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261287AbULAQHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:07:08 -0500
Date: Wed, 1 Dec 2004 17:06:32 +0100
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
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201160632.GA3018@elte.hu>
References: <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <48590.195.245.190.94.1101810584.squirrel@195.245.190.94> <20041130131956.GA23451@elte.hu> <17532.195.245.190.94.1101829198.squirrel@195.245.190.94> <20041201103251.GA18838@elte.hu> <32831.192.168.1.5.1101905229.squirrel@192.168.1.5> <20041201154046.GA15244@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201154046.GA15244@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> this shows an interesting phenomenon: for whatever reason IRQ5's
> thread didnt run until timestamp 1.946ms. There is lots of idle time
> between timestamps 0.012ms and 1.946ms, so this must be some weird
> condition. 

ok, this could be ACPI CPU-sleep related. Could you disable all ACPI
options in your .config (as a workaround), and re-check whether the
xruns still occur?

	Ingo
