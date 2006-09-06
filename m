Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWIFWkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWIFWkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWIFWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:40:16 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:6412 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964858AbWIFWj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:39:28 -0400
Date: Wed, 6 Sep 2006 23:39:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Josef Whiter <jwhiter@redhat.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFE: add io= option to 8250 serial console
Message-ID: <20060906223922.GA28943@flint.arm.linux.org.uk>
Mail-Followup-To: Josef Whiter <jwhiter@redhat.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060906212236.GC6841@korben.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906212236.GC6841@korben.rdu.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 05:22:37PM -0400, Josef Whiter wrote:
> This patch is against a recent git clone of Linus's tree.  This patch adds
> the ability to set the iobase for the serial port being used when you
> specify a serial device for the console on bootup, ie
> 
> console=ttyS0,io=0x3f8

Have you looked at 8250_early.c already in the kernel?

        console=        [KNL] Output console device and options.

                uart,io,<addr>[,options]
                uart,mmio,<addr>[,options]
                        Start an early, polled-mode console on the 8250/16550
                        UART at the specified I/O port or MMIO address,
                        switching to the matching ttyS device later.  The
                        options are the same as for ttyS, above.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

