Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWBAFKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWBAFKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWBAFK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:10:27 -0500
Received: from spooner.celestial.com ([192.136.111.35]:25736 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030335AbWBAFKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:10:18 -0500
Date: Wed, 1 Feb 2006 00:16:13 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060201051613.GH23039@kurtwerks.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060129144533.128af741.akpm@osdl.org> <20060201043824.GF23039@kurtwerks.com> <20060131204045.67b57e17.akpm@osdl.org> <20060201045713.GG23039@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201045713.GG23039@kurtwerks.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 11:57:13PM -0500, Kurt Wall took 1598 lines to write:
> On Tue, Jan 31, 2006 at 08:40:45PM -0800, Andrew Morton took 41 lines to write:
> > Kurt Wall <kwall@kurtwerks.com> wrote:
> > >
> > > On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton took 397 lines to write:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> > > 
> > > depmod loop:
> > > 
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
> Right. See below. I'm testing this out now, but I think it might be due
> having included kgdb support.

Disabling kgdb support makes the depmood loop go away.

Kurt
-- 
Magnocartic, adj.:
	Any automobile that, when left unattended, attracts shopping
carts.
		-- Sniglets, "Rich Hall & Friends"
