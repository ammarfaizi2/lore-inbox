Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVGWHlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVGWHlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGWHlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 03:41:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29709 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261446AbVGWHlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 03:41:02 -0400
Date: Sat, 23 Jul 2005 08:40:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: fix suspend/resume irq request free for yenta..
Message-ID: <20050723084049.A7921@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
References: <Pine.LNX.4.58.0507222331580.15287@skynet> <200507221816.19424.dtor_core@ameritech.net> <20050723002924.GA1988@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050723002924.GA1988@elf.ucw.cz>; from pavel@ucw.cz on Sat, Jul 23, 2005 at 02:29:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 02:29:24AM +0200, Pavel Machek wrote:
> > Is it necessary to do free_irq for suspend? Shouldn't disable_irq
> > be enough?
> 
> Due to recent changes in ACPI, yes, it is neccessary.

What if some other driver is sharing the IRQ, and requires IRQs to be
enabled for the resume to complete?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
