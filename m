Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUCPTc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCPTcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:32:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13575 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261421AbUCPTbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:31:20 -0500
Date: Tue, 16 Mar 2004 19:31:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>, Ian Campbell <icampbell@arcom.com>,
       netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Do not include linux/irq.h from linux/netpoll.h
Message-ID: <20040316193112.A4796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ian Campbell <icampbell@arcom.com>, netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1079369568.19012.100.camel@icampbell-debian> <20040316001141.C29594@flint.arm.linux.org.uk> <20040316192247.A7886@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040316192247.A7886@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Mar 16, 2004 at 07:22:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 07:22:47PM +0000, Russell King wrote:
> So how do we solve this problem.  Should I just merge this change and
> ask you to pull it?  I think that's rather impolite though.
> 
> Or should I send a BK cset which removes include/linux/irq.h entirely,
> thereby fixing _my_ problem (though it'll break everyone elses build.) 8)

What about moving it to asm-generic now?  linux/irq.h never was a public
API so the stable API in 2.6 thing doesn't count.  And it's fix the confusing
for real.

