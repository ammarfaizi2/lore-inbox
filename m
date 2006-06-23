Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932985AbWFWJ7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbWFWJ7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWFWJ7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:59:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28374 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932986AbWFWJ7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:59:44 -0400
Date: Fri, 23 Jun 2006 11:54:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 46/61] lock validator: special locking: slab
Message-ID: <20060623095449.GH4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212649.GT3155@elte.hu> <20060529183549.97a90e12.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183549.97a90e12.akpm@osdl.org>
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

> On Mon, 29 May 2006 23:26:49 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > +		/*
> > +		 * Do not assume that spinlocks can be initialized via memcpy:
> > +		 */
> 
> I'd view that as something which should be fixed in mainline.

yeah. I got bitten by this (read: pulled hair for hours) when converting 
the slab spinlocks to rtmutexes in the -rt tree.

	Ingo
