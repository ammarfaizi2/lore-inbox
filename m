Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWAHJIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWAHJIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWAHJII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:08:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751181AbWAHJIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:08:06 -0500
Date: Sun, 8 Jan 2006 09:08:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jason Dravet <dravet@hotmail.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, xavier.bestel@free.fr
Subject: Re: wrong number of serial port detected
Message-ID: <20060108090759.GA31219@flint.arm.linux.org.uk>
Mail-Followup-To: Jason Dravet <dravet@hotmail.com>, davej@redhat.com,
	linux-kernel@vger.kernel.org, xavier.bestel@free.fr
References: <20060107210544.GM9402@redhat.com> <BAY103-F39233F9F5FF4FEFA175808DF230@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY103-F39233F9F5FF4FEFA175808DF230@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 07:23:46PM -0600, Jason Dravet wrote:
> Not to keep complaining, but I now have the following issue.  I running 
> Fedora Cores  2.6.15-1.1826 kernel.  When I run dmesg I now see this:
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> 
> before 2.6.15 I saw
> Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
> 
> The serial driver now correctly reports that I have two serial ports 
> instead of 32.  So shouldn't the patch register the minimum of 
> CONFIG_SERIAL_8250_NR_UARTS and the number of serial ports detected by the 
> serial driver?

It's a classic chicken and egg problem.  If you can solve such problems,
please feel free to send a patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
