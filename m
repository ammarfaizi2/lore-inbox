Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTEVCJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 22:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTEVCJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 22:09:38 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:59778
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262456AbTEVCJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 22:09:37 -0400
Date: Wed, 21 May 2003 22:12:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Gerrit Huizenga <gh@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <jamesclv@us.ibm.com>, "" <haveblue@us.ibm.com>,
       "" <pbadari@us.ibm.com>, "" <linux-kernel@vger.kernel.org>,
       "" <johnstul@us.ibm.com>, "" <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
In-Reply-To: <20030522020443.GN2444@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305212205360.25777-100000@montezuma.mastecende.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com>
 <E19Idxq-0001LD-00@w-gerrit2> <20030522020443.GN2444@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, William Lee Irwin III wrote:

> This is not the case. Interrupt arbitration for sane things generally
> balances interrupt load automatically in-hardware. AIUI the TPR was
> intended to enable the hardware to do such a thing for xAPIC. Linux
> doesn't use the TPR now, which results in decisions made by the
> hardware on xAPIC -based SMP systems that are highly detrimental to
> performance.

Well using the APIC arbitration round robin thing isn't all that smart 
either unless you use the TPR, so TPR would be a win everywhere.

> IMHO Linux on Pentium IV should use the TPR in conjunction with _very_
> simplistic interrupt load accounting by default and all more
> sophisticated logic should be punted straight to userspace as an
> administrative API.
> 
> i.e. frob the fscking TPR as recommended by the APIC docs every once in
> a while by default, punt anything (and everything) fancier up to
> userspace, and get the code that doesn't even understand what the fsck
> DESTMOD means the Hell out of the kernel and the Hell away from my
> IO-APIC RTE's.

Word... This is all rather tired, if we have a working irq affinity user 
accessible interface this can all go away, so how about we just work 
towards that means, and then remove kirqd when everyone is happy 
(personally i like Arjan's/RH9 userland irqbalance).

	Zwane
-- 
function.linuxpower.ca
