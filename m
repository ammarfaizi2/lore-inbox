Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbVHSWtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbVHSWtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbVHSWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:49:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53522 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932738AbVHSWtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:49:10 -0400
Date: Sat, 20 Aug 2005 00:49:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, linux-parport@lists.infradead.org
Subject: 2.6.13-rc6-mm1 broke parallel port printer
Message-ID: <20050819224908.GA3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
> +fix-handling-in-parport_pc-init-code.patch
> 
>  parport fix
>...

This patch broke my parallel port printer.

diff between 2.6.13-rc6-mm1 and 2.6.13-rc6-mm1 with this patch reverted
(the reason for the input message being earlier might simply be that 
a working parport initialization takes some time):

<--  snip  -->

...
 radeonfb (0000:01:00.0): ATI Radeon QY 
 lp: driver loaded but no devices found
 Real Time Clock Driver v1.12
 Non-volatile memory driver v1.2
 Linux agpgart interface v0.101 (c) Dave Jones
 agpgart: Detected SiS 746 chipset
 agpgart: AGP aperture is 64M @ 0xd0000000
 [drm] Initialized drm 1.0.0 20040925
 ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
 [drm] Initialized radeon 1.17.0 20050311 on minor 0: 
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 mice: PS/2 mouse device common for all mice
+parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
+parport0: irq 7 detected
+input: AT Translated Set 2 keyboard on isa0060/serio0
+parport0: Legacy device
+lp0: using parport0 (polling).
 io scheduler noop registered
...
 saa7134[0]: board init: gpio is 100a0
-input: AT Translated Set 2 keyboard on isa0060/serio0
 saa7134[0]: Huh, no eeprom present (err=-5)?
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

