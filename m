Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWBAJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWBAJec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWBAJec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:34:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8973 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030214AbWBAJeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:34:31 -0500
Date: Wed, 1 Feb 2006 09:34:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060201093424.GC27735@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org
References: <20060129144533.128af741.akpm@osdl.org> <20060201043824.GF23039@kurtwerks.com> <20060131204045.67b57e17.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131204045.67b57e17.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 08:40:45PM -0800, Andrew Morton wrote:
> Kurt Wall <kwall@kurtwerks.com> wrote:
> > $ sudo make modules_install:
> > ...
> >   INSTALL sound/soundcore.ko
> >   if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> >   System.map  2.6.16-rc1-mm4krw-1; fi
> >   WARNING: Loop detected:
> >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko needs
> >   serial_core.ko which needs 8250.ko again!
> >   WARNING: Module
> >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko
> >   ignored, due to loop
> >   WARNING: Module
> >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/serial_core.ko
> >   ignored, due to loop
> >   WARNING: Module
> >   /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250_pci.ko
> >   ignored, due to loop
> >   [~/kernel/linux-2.6.16-rc1-mm4]$
> > 
> 
> ah.  .config, please?

It'll be the well-known kgdb problem in your tree.  You might want to
make a note of this for future reference.

It's been a while since this came up, but I thought someone was working
on a kgdb version which didn't have this yucky side effect.  It's now
far too long ago for me to remember who it was.

What happened to getting that into -mm instead of this obviously buggy
version?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
