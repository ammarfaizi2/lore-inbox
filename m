Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUIJARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUIJARI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIJAOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:14:17 -0400
Received: from holomorphy.com ([207.189.100.168]:45236 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266582AbUIJAJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:09:13 -0400
Date: Thu, 9 Sep 2004 17:09:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910000903.GS3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16704.59668.899674.868174@cargo.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> The semantics of profile_pc() have never included backtracing through
>> scheduling primitives, so I'd say just report __preempt_spin_lock().

On Fri, Sep 10, 2004 at 09:36:52AM +1000, Paul Mackerras wrote:
> I disagree that __preempt_spin_lock is a scheduling primitive, or at
> least I disagree that it is primarily a scheduling primitive.  We
> don't spend vast amounts of time spinning in any of the other
> scheduling primitives; if we have to wait we call schedule().

Unfortunately the alternative appears to be stack unwinding in
profile_pc(), which was why I hoped we could punt. Any other ideas?


-- wli
