Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVASJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVASJW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVASJWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:22:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50865 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261663AbVASJUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:20:23 -0500
Date: Wed, 19 Jan 2005 10:20:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Tony Luck <tony.luck@intel.com>, Darren Williams <dsw@gelato.unsw.edu.au>,
       Andrew Morton <akpm@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050119092013.GA2045@elte.hu>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050116230922.7274f9a2.akpm@osdl.org> <20050117143301.GA10341@elte.hu> <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
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


* Peter Chubb <peterc@gelato.unsw.edu.au> wrote:

> >> Here's a patch that adds the missing read_is_locked() and
> >> write_is_locked() macros for IA64.  When combined with Ingo's
> >> patch, I can boot an SMP kernel with CONFIG_PREEMPT on.
> >> 
> >> However, I feel these macros are misnamed: read_is_locked() returns
> >> true if the lock is held for writing; write_is_locked() returns
> >> true if the lock is held for reading or writing.
> 
> Ingo> well, 'read_is_locked()' means: "will a read_lock() succeed"
> 
> Fail, surely?

yeah ... and with that i proved beyond doubt that the naming is indeed
unintuitive :-)

	Ingo
