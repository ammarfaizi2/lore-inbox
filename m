Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWIKF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWIKF4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIKF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:56:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48556 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964874AbWIKF4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:56:38 -0400
Date: Mon, 11 Sep 2006 07:48:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
Message-ID: <20060911054855.GD11269@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu> <200609110741.27284.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609110741.27284.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Monday 11 September 2006 07:25, Ingo Molnar wrote:
> > Jeremy,
> >
> > could you back out Andi's patch and try the patch below, does it fix the
> > crash too?
> 
> iirc the crash was long before any system calls could be called 
> (except maybe kernel_thread/clone, but for that %gs doesn't change)

the screenshot from Laurent:

   http://laurent.riffard.free.fr/2.6.18-rc6-mm1/

shows a much later crash, which crash is consistent with the bug fixed 
by my patch.

	Ingo
