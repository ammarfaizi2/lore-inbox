Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291510AbSBADlx>; Thu, 31 Jan 2002 22:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291511AbSBADlb>; Thu, 31 Jan 2002 22:41:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18318 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291510AbSBADlT>;
	Thu, 31 Jan 2002 22:41:19 -0500
Date: Thu, 31 Jan 2002 22:41:17 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Bob Miller <rem@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3 remove global semaphore_lock spin lock.
Message-ID: <20020131224117.E21864@havoc.gtf.org>
In-Reply-To: <20020131150139.A1345@doc.pdx.osdl.net> <3C59D956.4F2B85DB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C59D956.4F2B85DB@zip.com.au>; from akpm@zip.com.au on Thu, Jan 31, 2002 at 03:55:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:55:02PM -0800, Andrew Morton wrote:
> > +       unsigned long flags;
> > +       wq_write_lock_irqsave(&sem->wait.lock, flags);
> > -       spin_lock_irq(&semaphore_lock);
> 
> I rather dislike spin_lock_irq(), because it's fragile (makes

It's less flexible for architectures, too.

spin_lock_irqsave is considered 100% portable AFAIK, and I make it my
own policy to s/_irq/_irqsave/ when the opportunity strikes in my PCI
drivers.

	Jeff


