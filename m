Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVATREd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVATREd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVATRER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:04:17 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53981 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262237AbVATQ7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:59:51 -0500
Date: Thu, 20 Jan 2005 17:59:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [patch 1/3] spinlock fix #1, *_can_lock() primitives
Message-ID: <20050120165937.GA17262@elte.hu>
References: <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu> <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org> <20050120164428.GA16342@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120164428.GA16342@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > I can do ppc64 myself, can others fix the other architectures (Ingo,
> > shouldn't the UP case have the read/write_can_lock() cases too? And
> > wouldn't you agree that it makes more sense to have the rwlock test
> > variants in asm/rwlock.h?):
> 
> this one adds it to x64. (untested at the moment) [...]

with this patch the x64 SMP+PREEMPT kernel builds & boots fine on an UP
x64 box. (this is not a full test but better than nothing.) [the other 8
spinlock patches were all applied as well.]

	Ingo
