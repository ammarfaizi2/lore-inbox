Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbUJaLgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUJaLgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbUJaLfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:35:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:57003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbUJaKut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:50:49 -0500
Date: Sun, 31 Oct 2004 02:48:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-Id: <20041031024840.6eeee92d.akpm@osdl.org>
In-Reply-To: <4184C16E.80705@pobox.com>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	<4184BB09.8000107@pobox.com>
	<20041031021933.1eba86a6.akpm@osdl.org>
	<4184C16E.80705@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > 
> >>content looks OK, but patch appears to be whitespace-challenged...
> >>
> > 
> > 
> > It applies successfully.
> 
> I'm talking about the _other_ type of "whitespace challenged", such as,
> 
> -        volatile struct lance_regs *ll;
> +	unsigned long base;
> 
> 	and
> 
> -        void *va = dio_scodetoviraddr(scode);
> +	unsigned long pa = dio_scodetophysaddr(scode);
> +        unsigned long va = (pa + DIO_VIRADDRBASE);
> 
> Reading through the patch you can see other one-space-off spots.
> 

That's because the stoopid driver is using spaces instead of tabs all over
the place.  It comes out visually OK once the patch is applied.  But it's a
useful reminder of how much dreck we have in the tree.
