Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCVFLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUCVFLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:11:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:39657 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261744AbUCVFLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:11:50 -0500
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040322002041.I26708@flint.arm.linux.org.uk>
References: <20040321204931.A11519@infradead.org>
	 <1079902670.17681.324.camel@imladris.demon.co.uk>
	 <Pine.LNX.4.58.0403211349340.1106@ppc970.osdl.org>
	 <20040321222327.D26708@flint.arm.linux.org.uk> <405E1859.5030906@pobox.com>
	 <20040321225117.F26708@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0403211504550.1106@ppc970.osdl.org>
	 <405E23A5.7080903@pobox.com>
	 <Pine.LNX.4.58.0403211542051.1106@ppc970.osdl.org>
	 <405E2F0D.3050001@pobox.com> <20040322002041.I26708@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1079931449.912.183.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 15:57:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> exists because architectures haven't defined their private
> pgprot_writecombine() implementations, preferring instead to add
> to the preprocessor junk instead.

And it's not even about writecombine... Like writecombine is an
attribute of the PCI host bridge on pmacs, not a pgprot, while
cacheability issues cannot be always abstracted the same way on
different archs. Actually, GUARDED could be used for !writecombine
on ppc, but !GUARDED would allow prefetch and out of order IOs....

Ben.


