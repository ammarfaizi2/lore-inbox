Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSLQRLF>; Tue, 17 Dec 2002 12:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSLQRLF>; Tue, 17 Dec 2002 12:11:05 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265134AbSLQRLF>;
	Tue, 17 Dec 2002 12:11:05 -0500
Date: Tue, 17 Dec 2002 09:14:15 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move LOG_BUF_SIZE to header file
In-Reply-To: <20021217094150.A2467@infradead.org>
Message-ID: <Pine.LNX.4.33L2.0212170911120.17648-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Christoph Hellwig wrote:

| On Mon, Dec 16, 2002 at 10:11:42PM -0800, Randy.Dunlap wrote:
| > --- ./arch/i386/Kconfig%LOGBUF	Sun Dec 15 18:07:47 2002
| > +++ ./arch/i386/Kconfig	Sun Dec 15 20:45:09 2002
| > @@ -1573,6 +1573,43 @@
| >  	  If you don't debug the kernel, you can say N, but we may not be able
| >  	  to solve problems without frame pointers.
| >
| > +choice
| > +	prompt "Kernel log buffer size"
| > +	default LOG_BUF_128KB if ARCH_S390
| > +	default LOG_BUF_64KB if X86_NUMAQ || IA64
| > +	default LOG_BUF_32KB if SMP
| > +	default LOG_BUF_16KB
|
| yuck.  Why don't you just add and integer LOG_BUG_SHIFT symbol that can
| be freely choosen?

I'll think about that, see how it works out.
LOG_BUF_SHIFT seems reasonable (for developers, not for users), but I
think that there should be some decent defaults also.

-- 
~Randy

