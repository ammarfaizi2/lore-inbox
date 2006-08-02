Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWHBWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWHBWAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHBWAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:00:12 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:30984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932253AbWHBWAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:00:04 -0400
Date: Wed, 2 Aug 2006 22:59:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060802215958.GA19669@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Mathias Adam <a2@adamis.de>
References: <20060802194938.GL5972@redhat.com> <1154556536.23655.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154556536.23655.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:08:56PM +0100, Alan Cox wrote:
> Ar Mer, 2006-08-02 am 15:49 -0400, ysgrifennodd Dave Jones:
> > This patch has been submitted a number of times, and doesn't seem
> > to get any upstream traction, which is a shame, as it seems to work
> > for users, and I keep inadvertantly dropping it from the Fedora
> > kernel everytime I rebase it.
> 
> We really ought to do that based on the PCI subvendor/subdevice id of
> the boards in use if possible surely ? It ought to be safe for x86
> because nobody is going to use anything but chip default values so they
> can avoid needing a ROM.

Not correct - there are PCMCIA-based versions of these chips and they
do have weirdo values in the registers to cope with custom crystals
which magically vanish if you reset the UART.

dwmw2's 950-based bluetooth CF card does exactly this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
