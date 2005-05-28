Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVE1Svv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVE1Svv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVE1Svv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 14:51:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14300 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261176AbVE1Svt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 14:51:49 -0400
Date: Sat, 28 May 2005 20:51:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050528185123.GA13961@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org> <20050525135130.GA27088@elte.hu> <20050528173241.C4711@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528173241.C4711@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > The patch below should address this problem for all architectures, by 
> > doing an explicit schedule() in the init code before calling into 
> > cpu_idle().
> 
> Yuck - wouldn't it be better just to fix all the architectures instead 
> of applying band aid?

it's not really a bug in any architecture - it's a scheduler setup 
detail that i changed, and which i initially thought would be best 
handled in cpu_idle(), but which is easier to do in rest_init().

	Ingo
