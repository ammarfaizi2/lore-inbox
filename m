Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUILWGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUILWGX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUILWGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:06:20 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:41186 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S263117AbUILWGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:06:15 -0400
Date: Mon, 13 Sep 2004 00:07:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912220720.GC3049@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095025000.22893.52.camel@krustophenia.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 05:36:41PM -0400, Lee Revell wrote:
> But in this case the hardirq handler can run for 2ms, which caused a
> scheduler latency problem, because nothing could run but other IRQs. 
> The IRQ threading in Ingo's patches solves the problem, and seems to me
> to be the correct solution.

the irq threading must have a cost, doesn't it? I doubt you want to
offload irqs to a kernel thread on a server, *that* would be slow (irq
nesting is zerocost compared to scheduling a kernel thread).
