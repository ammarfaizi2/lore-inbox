Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278695AbRKOALi>; Wed, 14 Nov 2001 19:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRKOAL3>; Wed, 14 Nov 2001 19:11:29 -0500
Received: from [212.18.232.186] ([212.18.232.186]:22536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S278695AbRKOALI>; Wed, 14 Nov 2001 19:11:08 -0500
Date: Thu, 15 Nov 2001 00:10:16 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Patch] Some updates to serial-5.05
Message-ID: <20011115001016.C19575@flint.arm.linux.org.uk>
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com>; from stuartm@connecttech.com on Wed, Nov 14, 2001 at 10:47:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 10:47:44AM -0500, Stuart MacDonald wrote:
> Same patches, attached inline to avoid OE mangling.

I've merged the simple bits of this by hand with my serial CVS.  As I
said in a previous mail here, I'm not taking on the maintainence of the
existing serial.c driver.  Therefore, these comments apply to the
new serial driver, not the existing drivers.

> > patch-kernel: Adds 485 ioctls to the kernel proper

Not applied.

> > patch-serial-485: Adds 485 line mode switiching functionality to the
> > serial driver. Note: this is not 485 protocol-level support, but
> > electrical-level support.

Not applied.

These two I'd rather waited until we've got the driver merged into 2.5,
at which point I'd rather have a patch against the new driver.

> > patch-serial-16850: Adds detection of the XR16C2850.

Applied.

> > patch-serial-fctr: Fixes a bug where serial-5.05 wasn't preserving an
> > important bit in the fctr register when setting fifo triggers.

Applied.

> > patch-serial-devfs: Driver now reports the /dev entries in a manner
> > consistent with how they are created. Yes, we have had customers who
> > were thrown off by the discrepancy between ttyS00 and ttyS0.

I don't actually printk() the serial ports that have been discovered at
boot time in the new serial CVS.  If people scream enough, I could be
persuaded.  I'm currently of the opinion that they're noise, and if
we're really interested in them, we've got a userspace tool to do it
for us: setserial -bg /dev/ttyS* 

> > patch-serial-24x: serial-5.05 now finds our MULTISERIAL class boards.
> > Also adds serial_compat.h for all 2.4.x kernels I've tested it with.
> > This is necessary to compile in 2.4.x kernels.

Only the MULTISERIAL support applied - 2.4 has the PCI class definitions,
so when the new driver is merged, we already have the definitions.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

