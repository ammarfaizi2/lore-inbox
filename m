Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUJTKxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUJTKxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269917AbUJTKxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:53:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:27295 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269880AbUJTKwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:52:50 -0400
Subject: Re: New consolidate irqs vs . probe_irq_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041020100103.G1047@flint.arm.linux.org.uk>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	 <20041020083358.GB23396@elte.hu> <1098261745.6263.9.camel@gaston>
	 <20041020100103.G1047@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098269455.20955.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 20:50:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yenta_socket has always used it.  Its rather fundamental to the way
> that the PCMCIA core has worked for the last I don't know how many
> years.
> 
> Nothing new.  Maybe something in PPC64 land broke recently?

No, what happened is that until the big irq unification, ppc and ppc64
probe_* were no-ops. Probing of "ISA" irqs is a big no-no on most non
x86 architectures.

Ben.


