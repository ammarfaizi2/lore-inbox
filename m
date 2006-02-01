Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWBAJx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWBAJx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWBAJx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:53:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030344AbWBAJx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:53:58 -0500
Date: Wed, 1 Feb 2006 01:53:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: kwall@kurtwerks.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060201015327.18799caf.akpm@osdl.org>
In-Reply-To: <20060201093424.GC27735@flint.arm.linux.org.uk>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060201043824.GF23039@kurtwerks.com>
	<20060131204045.67b57e17.akpm@osdl.org>
	<20060201093424.GC27735@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Tue, Jan 31, 2006 at 08:40:45PM -0800, Andrew Morton wrote:
> > Kurt Wall <kwall@kurtwerks.com> wrote:
> > > $ sudo make modules_install:
> > > ...
> > >   INSTALL sound/soundcore.ko
> > >   if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> > >   System.map  2.6.16-rc1-mm4krw-1; fi
> > >   WARNING: Loop detected:
> > >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko needs
> > >   serial_core.ko which needs 8250.ko again!
> > >   WARNING: Module
> > >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko
> > >   ignored, due to loop
> > >   WARNING: Module
> > >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/serial_core.ko
> > >   ignored, due to loop
> > >   WARNING: Module
> > >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250_pci.ko
> > >   ignored, due to loop
> > >   [~/kernel/linux-2.6.16-rc1-mm4]$
> > > 
> > 
> > ah.  .config, please?
> 
> It'll be the well-known kgdb problem in your tree.  You might want to
> make a note of this for future reference.

That kgdb stub is slowly deteriorating as everyone hacks on everything
else.  I usually disable 8250 completely in config when I want to use it
nowadays.

> It's been a while since this came up, but I thought someone was working
> on a kgdb version which didn't have this yucky side effect.  It's now
> far too long ago for me to remember who it was.
> 
> What happened to getting that into -mm instead of this obviously buggy
> version?

Tom pops up with it every few months, I try to merge it, general havoc
ensues and it all goes quiet again.
