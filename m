Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIISA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIISA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUIIR5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:57:23 -0400
Received: from holomorphy.com ([207.189.100.168]:1714 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266391AbUIIRxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:53:30 -0400
Date: Thu, 9 Sep 2004 10:53:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909175314.GD3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
	Scott Wood <scott@timesys.com>,
	Arjan van de Ven <arjanv@redhat.com>
References: <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com> <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com> <20040908143143.A32002@infradead.org> <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909172401.GA28376@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 07:24:01PM +0200, Ingo Molnar wrote:
> you can find a pretty good approximation done by Scott Wood (and Andrey
> Panin?) in the ppc/ppc64 portion of the VP patches:
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-S0
> basically you only have to zap some of the irq-threading changes such as
> calls to redirect_hardirq(), do a s/generic_// and zap the PIC changes
> (these are done for redirection too). Scott has tested those changes so
> kernel/hardirq.c should work pretty well with ppc/ppc64.

By any chance can the generic code be made not to be reliant on
irq_desc[] and/or irq_desc[] being an array?


-- wli
