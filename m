Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUIIXhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUIIXhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUIIXhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:37:06 -0400
Received: from ozlabs.org ([203.10.76.45]:56777 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266880AbUIIXgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:36:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16704.59668.899674.868174@cargo.ozlabs.ibm.com>
Date: Fri, 10 Sep 2004 09:36:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Anton Blanchard <anton@samba.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <20040909220040.GM3106@holomorphy.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
	<16703.60725.153052.169532@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
	<20040909154259.GE11358@krispykreme>
	<20040909171954.GW3106@holomorphy.com>
	<16704.52551.846184.630652@cargo.ozlabs.ibm.com>
	<20040909220040.GM3106@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:

> The semantics of profile_pc() have never included backtracing through
> scheduling primitives, so I'd say just report __preempt_spin_lock().

I disagree that __preempt_spin_lock is a scheduling primitive, or at
least I disagree that it is primarily a scheduling primitive.  We
don't spend vast amounts of time spinning in any of the other
scheduling primitives; if we have to wait we call schedule().

Paul.
