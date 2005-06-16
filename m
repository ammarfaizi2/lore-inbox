Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVFPQHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVFPQHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 12:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVFPQHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 12:07:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17679 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261768AbVFPQG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 12:06:27 -0400
Date: Thu, 16 Jun 2005 17:06:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ISA DMA controller hangs
Message-ID: <20050616170622.A1712@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain> <42A2B610.1020408@drzeus.cx> <42A3061C.7010604@drzeus.cx> <42B1A08B.8080601@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B1A08B.8080601@drzeus.cx>; from drzeus-list@drzeus.cx on Thu, Jun 16, 2005 at 05:53:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 05:53:47PM +0200, Pierre Ossman wrote:
> So how do we solve this problem? We should do a master clear and then
> enable channel 4 after a suspend. The question is where. I see three
> possible places:
> 
> * In the suspend code in kernel/power.
> * In the driver actually handling the suspend (ACPI/APM/etc.).
> * Via the device layer by adding a device for the DMA controller.
> 
> Which would be the preferred solution?

Shouldn't there be a system device for the DMA controller?  I think
that should have appropriate hooks into the power management system
to do the necessary magic to restore whatever's needed - just like
we do for the PIC.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
