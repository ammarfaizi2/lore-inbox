Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbUJ0KVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUJ0KVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUJ0KUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:20:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46542 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262381AbUJ0KCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:02:44 -0400
Date: Wed, 27 Oct 2004 12:03:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027100341.GA26729@elte.hu>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027082831.GA15192@elte.hu> <20041027084401.GA15989@elte.hu> <20041027085221.GA16742@elte.hu> <20041027090620.GA17621@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027090620.GA17621@elte.hu>
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


> i've also uploaded -RT-V0.3.2 with this fix included.

note that if you are running amlat/realfeel then you should do something
like this after starting realfeel:

  chrt -f 99 -p `pidof 'IRQ 8'`
  chrt -f 98 -p `pidof realfeel`

because by default IRQ 8 has a lower RT priority than realfeel.

	Ingo
