Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUF2MFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUF2MFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265746AbUF2MFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:05:45 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11268 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265729AbUF2MFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:05:36 -0400
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040629111017.GB15414@elf.ucw.cz>
References: <200406070139.38433.kernel@kolivas.org>
	 <20040629111017.GB15414@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 29 Jun 2004 14:05:31 +0200
Message-Id: <1088510731.2728.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 13:10 +0200, Pavel Machek wrote:
> Hi!
> 
> > This is an update of the scheduler policy mechanism rewrite using the 
> > infrastructure of the current O(1) scheduler. Slight changes from the 
> > original design require a detailed description. The change to the original 
> > design has enabled all known corner cases to be abolished and cpu 
> > distribution to be much better maintained. It has proven to be stable in my 
> > testing and is ready for more widespread public testing now.
> > 
> > 
> > Aims:
> >  - Interactive by design rather than have interactivity bolted on.
> >  - Good scalability.
> >  - Simple predictable design.
> >  - Maintain appropriate cpu distribution and fairness.
> >  - Low scheduling latency for normal policy tasks.
> >  - Low overhead.
> >  - Making renicing processes actually matter for CPU distribution (nice 0 gets 
> > 20 times what nice +20 gets)
> >  - Resistant to priority inversion
> 
> How do you solve priority inversion?
> 
> Can you do "true idle threads" now? (I.e. nice +infinity?)

I think idle threads can be achieved with the batch scheduler policy
present in -ck patches. It works nicely, and I use it a lot.

PS: At least, if you mean with "idle threads" those that do only run
where there are idle cycles of CPU (i.e. all processes are sleeping).

