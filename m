Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUIJChx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUIJChx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIJChw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:37:52 -0400
Received: from holomorphy.com ([207.189.100.168]:40064 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267511AbUIJChh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:37:37 -0400
Date: Thu, 9 Sep 2004 19:37:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910023733.GC2616@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme> <20040910022204.GA2616@holomorphy.com> <20040910023258.GB2616@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910023258.GB2616@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:32:58PM -0700, William Lee Irwin III wrote:
> I ran into instant pain because various read_lock() -related locking
> primitives don't exist... first approximation:
> This patch folds __preempt_spin_lock() and __preempt_write_lock() into
> their callers, and follows Ingo's patch in sweeping various other locking
> variants into doing likewise for CONFIG_PREEMPT=y && CONFIG_SMP=y.
> Compiletested on ia64.

Don't bother with this, Ingo's preempt-smp.patch at least got
_raw_read_trylock() implemented so just use that.


-- wli
