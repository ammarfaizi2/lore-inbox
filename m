Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271430AbUJVQy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271430AbUJVQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271434AbUJVQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:51:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58567 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S271430AbUJVQud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:50:33 -0400
Date: Fri, 22 Oct 2004 18:51:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041022165138.GA25803@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FADC.6030905@cybsft.com> <1098384016.27089.42.camel@thomas> <41780687.8030408@cybsft.com> <1098385049.27089.51.camel@thomas> <41791564.20200@cybsft.com> <1098456218.8955.373.camel@thomas> <41792427.8020100@cybsft.com> <1098460673.8955.387.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098460673.8955.387.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> --- 2.6.9-rc4-mm1/drivers/net/tulip/tulip_core.c	2004-10-12

>  	pci_release_regions (pdev);
> +	pci_disable_device (pdev);
>  	pci_set_drvdata (pdev, NULL);

i've uploaded -U10.1 with this fix included plus a fix to the tg3 and
3c59x drivers. (the drivers would disable interrupts in
hard_start_xmit). I've also added debugging code to catch future
instances of this network driver related problem.

	Ingo
