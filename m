Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSLQJd6>; Tue, 17 Dec 2002 04:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSLQJd6>; Tue, 17 Dec 2002 04:33:58 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:31754 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264853AbSLQJd5>; Tue, 17 Dec 2002 04:33:57 -0500
Date: Tue, 17 Dec 2002 09:41:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move LOG_BUF_SIZE to header file
Message-ID: <20021217094150.A2467@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3DF64369.81F288FE@digeo.com> <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Mon, Dec 16, 2002 at 10:11:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 10:11:42PM -0800, Randy.Dunlap wrote:
> --- ./arch/i386/Kconfig%LOGBUF	Sun Dec 15 18:07:47 2002
> +++ ./arch/i386/Kconfig	Sun Dec 15 20:45:09 2002
> @@ -1573,6 +1573,43 @@
>  	  If you don't debug the kernel, you can say N, but we may not be able
>  	  to solve problems without frame pointers.
> 
> +choice
> +	prompt "Kernel log buffer size"
> +	default LOG_BUF_128KB if ARCH_S390
> +	default LOG_BUF_64KB if X86_NUMAQ || IA64
> +	default LOG_BUF_32KB if SMP
> +	default LOG_BUF_16KB

yuck.  Why don't you just add and integer LOG_BUG_SHIFT symbol that can
be freely choosen?

