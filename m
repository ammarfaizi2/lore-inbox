Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbTEGERb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbTEGERb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:17:31 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:387
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S262834AbTEGERa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:17:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16056.35787.271296.678842@panda.mostang.com>
Date: Tue, 6 May 2003 21:30:03 -0700
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, davidm@mostang.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] fixing the irqwcpustat mess
In-Reply-To: <1052281495.18422.48.camel@averell>
References: <20030505212546.A24006@lst.de>
	<1052281495.18422.48.camel@averell>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 07 May 2003 06:24:54 +0200, Andi Kleen <ak@suse.de> said:

  Andi> On Mon, 2003-05-05 at 21:25, Christoph Hellwig wrote:
  >>  +#ifndef __ARCH_IRQ_STAT irq_cpustat_t irq_stat[NR_CPUS]
  >> ____cacheline_aligned; +EXPORT_SYMBOL(irq_stat); +#endif

  Andi> Shouldn't this be per_cpu_data ?

That's what we do on ia64.  Though we actually end up putting it in
the cpuinfo structure, for historical reasons but also to ensure that
it's close to some other stuff that's used on the irq path.

	--david
