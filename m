Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWHBPam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWHBPam (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHBPam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:30:42 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64135 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751206AbWHBPam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:30:42 -0400
Date: Wed, 2 Aug 2006 17:24:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix initialization of runqueues
Message-ID: <20060802152419.GA31970@elte.hu>
References: <20060802122743.GF4460@implementation.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802122743.GF4460@implementation.labri.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Hi,
> 
> There's an odd thing about the nr_active field in arrays of 
> runqueue_t: it is actually never initialized to 0!...  This doesn't 
> yet trigger a bug probably because the way runqueues are allocated 
> make it so that it is already initialized to 0, but that's not a safe 
> way.  Here is a patch:

we do rely on zero initialization of bss (and percpu) data in a number 
of places.

	Ingo
