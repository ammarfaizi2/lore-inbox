Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbUJ1ViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbUJ1ViD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbUJ1VgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:36:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:54461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbUJ1VeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:34:00 -0400
Date: Thu, 28 Oct 2004 14:37:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: dsaxena@plexity.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove inclusion of <linux/irq.h> from pci/quirks.c
Message-Id: <20041028143753.338c1b7e.akpm@osdl.org>
In-Reply-To: <20041028211432.GB9369@kroah.com>
References: <20041020182222.GA20201@plexity.net>
	<20041020215750.3f3764e6.akpm@osdl.org>
	<20041028211432.GB9369@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > Also, it worries me that quirk_intel_irqbalance() is marked __devinit and
> > calls irqbalance_disable(), which is marked __init.  I guess a fix for that
> > would be to mark quirk_intel_irqbalance() as __init, since it's unlikely to
> > be called after free_initmem().  Does Greg agree?
> 
> I do agree.  But I think the intel people are mucking around in this
> area too and hopefully they'll fix it all up soon...

It should all be fixed up now.  We moved the intel-specific quirk to the
new arch/i386/kernel/quirks.c.
