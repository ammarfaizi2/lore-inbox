Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVATNFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVATNFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVATNFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:05:16 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15001 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262140AbVATNFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:05:10 -0500
Date: Thu, 20 Jan 2005 14:04:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
Message-ID: <20050120130401.GA8061@elte.hu>
References: <20050118014752.GA14709@cse.unsw.EDU.AU> <16877.42598.336096.561224@wombat.chubb.wattle.id.au> <20050119080403.GB29037@elte.hu> <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
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

> I suggest reversing the sense of the macros, and having
> read_can_lock() and write_can_lock()
> 
> Meaning:
> 	read_can_lock() --- a read_lock() would have succeeded
> 	write_can_lock() --- a write_lock() would have succeeded.

i solved the problem differently in my patch sent to lkml today: i
introduced read_trylock_test()/etc. variants which mirror the semantics
of the trylock primitives and solve the needs of the PREEMPT branch
within kernel/spinlock.c.

	Ingo
