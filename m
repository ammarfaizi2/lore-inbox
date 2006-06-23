Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWFWHP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWFWHP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbWFWHP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:15:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:15551 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932900AbWFWHPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:15:55 -0400
Date: Fri, 23 Jun 2006 09:11:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [patch] lock validator: rtmutex unlock order annotation
Message-ID: <20060623071100.GA29321@elte.hu>
References: <20060622085706.GA29136@elte.hu> <20060622184025.3110879c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622184025.3110879c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +	spin_unlock_non_nested(&task->pi_lock);
> > +	local_irq_restore(flags);
> 
> y'know, if an innocent civilian were to stumble across this code he or 
> she would wonder "wtf is that doing"?

most definitely! I'll clean that up (and the other items as well).

	Ingo
