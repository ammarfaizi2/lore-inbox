Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVJQHrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVJQHrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJQHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:47:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932144AbVJQHrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:47:24 -0400
Date: Mon, 17 Oct 2005 08:47:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051017074717.GA24608@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20051016154108.25735ee3.akpm@osdl.org> <6bffcb0e0510161713l7c3abbdq@mail.gmail.com> <20051016201920.53db2b89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051016201920.53db2b89.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 08:19:20PM -0700, Andrew Morton wrote:
> Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > I have noticed some warnings while "make modules_install"
> > 
> > if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
> > System.map  2.6.14-rc4-mm1; fi
> > WARNING: Module
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/serial_core.ko
> > ignored, due to loop
> > WARNING: Module
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pnp.ko ignored,
> > due to loop
> > WARNING: Module
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_pci.ko ignored,
> > due to loop
> > WARNING: Module
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250_acpi.ko
> > ignored, due to loop
> > WARNING: Loop detected:
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko needs
> > serial_core.ko which needs 8250.ko again!
> > WARNING: Module
> > /lib/modules/2.6.14-rc4-mm1/kernel/drivers/serial/8250.ko ignored, due
> > to loop
> 
> Beats me.  Please send .config.

It's good ole kgdb.  FWIW, Tom Rini's version which has been posted
several times to lkml doesn't have this issue.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
