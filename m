Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUB1WiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUB1WiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 17:38:09 -0500
Received: from mail.convergence.de ([212.84.236.4]:57798 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261938AbUB1WiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 17:38:02 -0500
Date: Sat, 28 Feb 2004 23:39:41 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] further __KERNEL_SYSCALLS__ removal
Message-ID: <20040228223941.GC1994@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Arnd Bergmann <arnd@arndb.de>, arjanv@redhat.com,
	linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
References: <200402271835.48649.arnd@arndb.de> <1077904855.10066.2.camel@laptop.fenrus.com> <200402271957.47235.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402271957.47235.arnd@arndb.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 07:57:47PM +0100, Arnd Bergmann wrote:
> On Friday 27 February 2004 19:00, Arjan van de Ven wrote:
> > On Fri, 2004-02-27 at 18:35, Arnd Bergmann wrote:
> > > ===== drivers/media/dvb/frontends/alps_tdlb7.c 1.8 vs edited =====
> > > --- 1.8/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 03:09:55 2004
> > > +++ edited/drivers/media/dvb/frontends/alps_tdlb7.c	Thu Feb 26 23:57:05
> 
> >
> > this is the wrong way to "fix" this; might as well leave this driver as
> > is until it is fixed to use request_firmware()
> 
> My idea was to finally eliminate __KERNEL_SYSCALLS__ without breaking
> the in-tree drivers, so I changed all I could.
> This patch leaves the syscalls in device drivers and fixes all
> necessary uses in init/*.c.
> Maybe we can find a better solution for calling execve in do_linuxrc(),
> run_init_process() and ____call_usermodehelper(). Then a #warning can
> be added __KERNEL_SYSCALLS__ is defined.

Michael Hunold already has some patches to change DVB to
use the kernel I2C stuff, so we can then convert frontends
to use request_firmware() properly. However, this work
is not finished yet, and needs more testing.

Johannes
