Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWAQVkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWAQVkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAQVkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:40:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751337AbWAQVkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:40:32 -0500
Date: Tue, 17 Jan 2006 13:40:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       asun@darksunrising.com
Subject: Re: PATCH: cassini printk format warning
Message-Id: <20060117134010.1e48fd79.akpm@osdl.org>
In-Reply-To: <20060117213442.GA22002@mipter.zuzino.mipt.ru>
References: <1137523175.14135.84.camel@localhost.localdomain>
	<20060117213442.GA22002@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Tue, Jan 17, 2006 at 06:39:34PM +0000, Alan Cox wrote:
> > --- linux.vanilla-2.6.16-rc1/drivers/net/cassini.c
> > +++ linux-2.6.16-rc1/drivers/net/cassini.c
> > @@ -1925,7 +1925,7 @@
> >  	u64 compwb = le64_to_cpu(cp->init_block->tx_compwb);
> >  #endif
> >  	if (netif_msg_intr(cp))
> > -		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %lx\n",
> > +		printk(KERN_DEBUG "%s: tx interrupt, status: 0x%x, %llx\n",
> >  			cp->dev->name, status, compwb);
> 
> 	"%llx", (unsigned long long)u64
> 
> is the warningless way on all archs.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/cassini-printk-fix.patch
