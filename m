Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVKWRa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVKWRa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKWRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:30:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45070 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751262AbVKWRa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:30:28 -0500
Date: Wed, 23 Nov 2005 17:30:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Christmas list for the kernel
Message-ID: <20051123173020.GL15449@flint.arm.linux.org.uk>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com> <20051123144437.GB7328@ucw.cz> <200511231221.27781.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511231221.27781.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 12:21:27PM -0500, Gene Heskett wrote:
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> 
> I had posted about this before, but it was apparently lost in the lists
> general noise.   I do use both ports here, and they are working, so I
> hadn't pursued it further.

So has the answer.  I've answered this twice today, and several times
in bugzilla.  It's one reason why these lines are now prefixed with
"serial8250" - that being the struct device to which they end up being
associated with.  (defaulting to "serial8250" for power management
purposes if no other exists.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
