Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUEVCRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUEVCRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUEVCOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:14:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:58074 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264524AbUEVCLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:11:03 -0400
Date: Fri, 21 May 2004 19:10:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-Id: <20040521191018.5454abc6.akpm@osdl.org>
In-Reply-To: <E1BR7pl-0000Br-00@gondolin.me.apana.org.au>
References: <20040521100734.GA31550@elf.ucw.cz>
	<E1BR7pl-0000Br-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Pavel Machek <pavel@ucw.cz> wrote:
>  > 
>  > --- tmp/linux/arch/i386/mm/init.c       2004-05-20 23:08:05.000000000 +0200
>  > +++ linux/arch/i386/mm/init.c   2004-05-20 23:10:50.000000000 +0200
>  > @@ -331,6 +331,13 @@
>  > void zap_low_mappings (void)
>  > {
>  >        int i;
>  > +
>  > +#ifdef CONFIG_SOFTWARE_SUSPEND
> 
>  Can you please define this for CONFIG_PM_DISK as well? Alternatively,
>  you can do the same as you did in cpu.c and define this for CONFIG_PM.

Pleeeeeze don't remove me from Cc when replying to emails.  Thanks.
