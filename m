Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbTECElK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 00:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTECElK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 00:41:10 -0400
Received: from holomorphy.com ([66.224.33.161]:60899 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263257AbTECElJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 00:41:09 -0400
Date: Fri, 2 May 2003 21:53:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu change
Message-ID: <20030503045322.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <16050.41490.798865.517036@napali.hpl.hp.com> <20030503044617.DE0642C003@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030503044617.DE0642C003@lists.samba.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16050.41490.798865.517036@napali.hpl.hp.com> you write:
>>  - On NUMA, you want to allocate the per-CPU areas in node-local memory.

On Sat, May 03, 2003 at 02:40:57PM +1000, Rusty Russell wrote:
> Thanks: I'd forgotten about this.  Even "big smp" machines often have
> different memory latencies.

I have already a patch to do this for ia32 NUMA systems (which present
issues not present on sane architectures).

I also didn't notice the lack of an override; #undef'ing the macro
__GENERIC_PER_CPU appeared to suffice for me.


-- wli
