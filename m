Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUIHNRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUIHNRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUIHNNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:13:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:64519 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267457AbUIHNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:12:20 -0400
Date: Wed, 8 Sep 2004 14:12:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
Message-ID: <20040908141217.A31690@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org> <20040908124547.GA19231@elte.hu> <20040908134903.A31498@infradead.org> <20040908130552.GC20132@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908130552.GC20132@elte.hu>; from mingo@elte.hu on Wed, Sep 08, 2004 at 03:05:52PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 03:05:52PM +0200, Ingo Molnar wrote:
> i disagree. It's the same as the VFS model: we have generic_block_bmap()
> which a filesystem might or might not make use of. It's still around
> even if no filesystem makes use of it but do we care? I'd prefer fixing
> our linking logic to get rid of unused functions than complicating code
> and the architecture with conditionals.

Completley different model.  VFS supports lots of filesystem implementation
with one interface.  IRQ code is a a single implementation for each
architecture.

> is there any architecture that cannot make use of kernel/hardirq.c _at
> all_?

s390 doesn't need it at all because it doesn't have the concept of hardirqs.

At least arm{,26}, m68k{,nommu} and parisc and sparc{,64} use extremly
different models for irq handling

