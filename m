Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUIIPtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUIIPtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUIIPsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:48:13 -0400
Received: from ozlabs.org ([203.10.76.45]:53180 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265999AbUIIPpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:45:39 -0400
Date: Fri, 10 Sep 2004 01:43:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040909154259.GE11358@krispykreme>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I think that bit is actually intentional since __preempt_spin_lock is also 
> marked __sched so that it'll get charged as a scheduling function.

Yeah, its a bit unfortunate. In profiles with preempt on we end up with
almost all our ticks inside __preempt_spin_lock and never get to use the
nice profile_pc code. I ended up turning preempt off again.

Anton
