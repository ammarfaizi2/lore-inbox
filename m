Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263071AbVEIHei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVEIHei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 03:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVEIHei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 03:34:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49320 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263071AbVEIHeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 03:34:36 -0400
Date: Mon, 9 May 2005 09:30:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050509073043.GA12976@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407> <427C6D7D.878935F1@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427C6D7D.878935F1@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> Daniel Walker wrote:
> >
> > Make a patch .
> 
> Will do. However, I'm unfamiliar with Ingo's tree, so I
> can send only new plist's implementation.

i've uploaded my latest tree to:

    http://redhat.com/~mingo/realtime-preempt/

it's easy to give it a go, it's pretty much plug & play, just apply 
these patches ontop of a vanilla 2.6.11 kernel tree:

   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0.7.47-00

take your usual .config, do a 'make oldconfig', make sure you pick up 
PREEMPT_RT (you can leave all the other .config options at their default 
values), recompile and you should be set. All RT tasks (SCHED_FIFO, 
SCHED_RR) will get PI handling and will use the plist.h code.

	Ingo
