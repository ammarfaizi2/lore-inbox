Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVKPJTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVKPJTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKPJTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:19:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36572 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030257AbVKPJTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:19:07 -0500
Date: Wed, 16 Nov 2005 10:19:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oliver Neukum <oliver@neukum.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116091913.GA19869@elte.hu>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <1132128212.2834.17.camel@laptopd505.fenrus.org> <200511160934.21444.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511160934.21444.oliver@neukum.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oliver Neukum <oliver@neukum.org> wrote:

> Am Mittwoch, 16. November 2005 09:03 schrieb Arjan van de Ven:
> > * less CPU cache footprint due to interrupt stacks
> >    - interrupt stacks are per cpu now instead of borrowing the per
> >      thread stack space; this both has less impact on the caches, and
> >      has more cache hits; the per cpu stack will be in cache more than
> >      the previously scattered bits and pieces
> > * more stack space is available for interrupts compared to 2.4 kernels
> >    - in 2.4 kernels only 2Kb was available for interrupt context (to
> >      keep 4K available for user context). With complex softirqs such as
> >      PPP and firewall rules and nested interrupts this wasn't always
> >      enough. Compared to 2.6-with-8Kstacks is a bit harder; there is
> >      2Kb extra available there compared to 2.4 and arguably some of that
> >      extra is for interrupts.
> 
> This is due to having interrupt stacks. Is there any reason not to 
> have 8K task stacks and per CPU interrupt stacks?

yes, all the other arguments you snipped :) Arjan wrote 4K+4K stacks for 
Fedora almost 2 years ago, and the patch has a good track record. Here's 
some more background info about 4K+4K stacks:

 http://lwn.net/Articles/84583/
 http://lwn.net/Articles/150580/
 http://lwn.net/Articles/160138/

	Ingo
