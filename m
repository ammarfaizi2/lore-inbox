Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRBAPUg>; Thu, 1 Feb 2001 10:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130578AbRBAPU1>; Thu, 1 Feb 2001 10:20:27 -0500
Received: from mail.delrom.ro ([193.231.234.28]:31237 "HELO mail.delrom.ro")
	by vger.kernel.org with SMTP id <S130532AbRBAPUJ>;
	Thu, 1 Feb 2001 10:20:09 -0500
Date: Thu, 1 Feb 2001 17:19:28 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 DAC960 driver bug or what's going on?
Message-Id: <20010201171928.3e8e964c.silviu@delrom.ro>
X-Mailer: Sylpheed version 0.4.60 (GTK+ 1.2.8; Linux 2.4.1; i686)
Organization: Delta Romania
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.5.0.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
A plain and honest Intel BX mainboard (AOpen AX6BC with latest BIOS
update), Pentium II/333, 64MB RAM, dumb PCI 1MB video card, Mylex
AcceleRAID 170 PCI controller, Quantum Atlas IV hard-disks.

Kernel 2.4.1

I want to install the system on the RAID volume, and for this purpose I
compiled the DAC960/DAC1100 driver into the kernel.

Made a boot floppy from RedHat distribution images and copied my kernel
with Mylex support on it.

Here are the relevant messages

[...]
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:07.2
PCI: The same IRQ used for device 00:0d.1
Limiting direct PCI/PCI transfers
[...]
PCI: Found IRQ 11 for device 00:0d.1
PCI: The same IRQ used for device 00:07.2
DAC960: ***** DAC960 RAID Driver version 2.4.9 of 7 September 2000 *****
DAC960: Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Kernel panic: DAC960: Logical Drive Block Size 0 not supported

I really don't know what the other device on IRQ 11 would be, since
there are no other add-in cards than video and RAID controller.

Same thing happened on an EPoX mainboard, before I tried the controller
with this hardware.  No matter what IRQ Mylex gets, linux says there's
another device using it.  What would be that device?  PS/2 mouse
controller, perhaps?  Why does it stick to Mylex?

Thank you for your help.
-- 
Systems and Network Administrator - Delta Romania
Phone +4093-267961
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
