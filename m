Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVATRDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVATRDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVATQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 11:59:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63964 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262251AbVATQ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 11:57:12 -0500
Date: Thu, 20 Jan 2005 17:57:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [patch 1/3] spinlock fix #1, *_can_lock() primitives
Message-ID: <20050120165702.GA17182@elte.hu>
References: <16878.9678.73202.771962@wombat.chubb.wattle.id.au> <20050119092013.GA2045@elte.hu> <16878.54402.344079.528038@cargo.ozlabs.ibm.com> <20050120023445.GA3475@taniwha.stupidest.org> <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org> <16879.29449.734172.893834@wombat.chubb.wattle.id.au> <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu> <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> I don't want to break all the other architectures. Or at least not
> most of them. Especially since I was hoping to do a -pre2 soon (well,
> like today, but I guess that's out..) and make the 2.6.11 cycle
> shorter than 2.6.10.

if we remove the debugging check from exit.c then the only thing that
might break in an architecture is SMP+PREEMPT, which is rarely used
outside of the x86-ish architectures.

	Ingo
