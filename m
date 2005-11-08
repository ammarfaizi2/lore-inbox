Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVKHXXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVKHXXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKHXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:23:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964940AbVKHXXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:23:25 -0500
Date: Tue, 8 Nov 2005 23:23:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts
Message-ID: <20051108232316.GH13357@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel@vger.kernel.org
References: <1131481677.8541.24.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131481677.8541.24.camel@tdi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 01:27:57PM -0700, Alex Williamson wrote:
> Hi Russell,
> 
>    The patch below works around a minor bug found in the UART of the
> remote management card used in many HP ia64 and parisc servers (aka the
> Diva UARTs).

Would setting UART_BUG_TXEN help ?

UART_BUG_TXEN is set for ports which need a kick up their backsides
to get their transmit interrupt status asserted, so that when new
chars are placed in the ring buffer we start transmitting them.

Your problem sounds very similar to this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
