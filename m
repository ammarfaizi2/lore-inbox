Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTGHQ5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTGHQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:57:52 -0400
Received: from ns.suse.de ([213.95.15.193]:8460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264809AbTGHQ5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:57:52 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES for CryptoAPI - i586-optimized
References: <20030708152755.GA24331@ghanima.endorphin.org.suse.lists.linux.kernel>
	<20030708174907.A18997@infradead.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2003 19:12:27 +0200
In-Reply-To: <20030708174907.A18997@infradead.org.suse.lists.linux.kernel>
Message-ID: <p737k6tq6x0.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jul 08, 2003 at 05:27:55PM +0200, Fruhwirth Clemens wrote:
> > 
> > Due to the recent discussion about the asm-optimized version of AES which is
> > included in loop-AES, I'd like to point out that I've ported this
> > implementation - Dr. Brian Gladman's btw. - to CryptoAPI a long time ago.
> 
> Cool, that means we just need to hash out the framework for optimized
> implementations now..

It's not cool. Pentium Classic tuning is quite useless for PPro+
The Pentium Classic had a quite weird pipeline and code optimized
for it tends to be suboptimal for more modern designs.

I didn't benchmark, but I suspect the C version compiled with a good compiler
for the correct CPU is faster than that on a modern CPU.

-Andi
