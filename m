Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbRFUTAK>; Thu, 21 Jun 2001 15:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbRFUTAA>; Thu, 21 Jun 2001 15:00:00 -0400
Received: from helene.ethz.ch ([129.132.63.50]:37136 "EHLO astro.phys.ethz.ch")
	by vger.kernel.org with ESMTP id <S265110AbRFUS7q>;
	Thu, 21 Jun 2001 14:59:46 -0400
Message-ID: <3B324410.A1D4DD5E@astro.phys.ethz.ch>
Date: Thu, 21 Jun 2001 20:59:28 +0200
From: Marc Audard <audard@astro.phys.ethz.ch>
Organization: Laboratory for Astrophysics, PSI & Institute of Astronomy, ETHZ
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marc Audard <audard@astro.phys.ethz.ch>
Subject: Bad bridge mapping problem: PCMCIA card not started
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope that I post this at the right place. There was
no answer at various other places. Please CC me for
any reply.

I would like to know if the problem I encounter can be
fixed:

I upgraded the system memory from 192 MB to 512 MB.
The system clearly detected the upgrade and linux booted.
However, at the cardmgr step, cardmgr complains not
finding an entry in /proc/devices for pcmcia (which is
correct). I checked with /var/log/syslog and apparently
the problem appears before, because of a bridge mapping problem.



in syslog:

kernel: Linux PCMCIA Card Services 3.1.25
kernel:  kernel build: 2.4.3-20mdk #1 Sun Apr 15 23:03:10 CEST 2001
kernel:   options: [pci] [cardbus] [apm]
kernel: Intel PCIC probe: PCI: Found IRQ 11 for device 00:03.0
kernel: PCI: The same IRQ used for device 00:03.1
kernel: PCI: The same IRQ used for device 00:07.2
kernel:
kernel:  Bad bridge mapping at 0x17ff0000!
kernel: not found
kernel: ds: no socket drivers loaded

This problem occurs with 256+64,256+128,256+256, but not 192 or
256 MB. The Multifunction Card I have is the 
XIRCOM Realport Ethernet 10/100-56K, known as REM56-100BTX


With 192 MB (when it's OK), the syslog message goes like this:



kernel: Linux PCMCIA Card Services 3.1.25
kernel:  kernel build: 2.4.3-20mdk #1 Sun Apr 15 23:03:10 CEST 2001
kernel:   options: [pci] [cardbus] [apm]
kernel: Intel PCIC probe: PCI: Found IRQ 11 for device 00:03.0
kernel: PCI: The same IRQ used for device 00:03.1
kernel: PCI: The same IRQ used for device 00:07.2
kernel: PCI: Found IRQ 11 for device 00:03.1
kernel: PCI: The same IRQ used for device 00:03.1
kernel: PCI: The same IRQ used for device 00:07.2
kernel: 
kernel:  TI 1420 rev 00 PCI-to-Cardbus at slot 00:03, mem 0x10000000
kernel:    hos opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 2/5]
kernel:    hos opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 32/32] [bus 6/9]
kernel: spurious 8259A interrupt: IRQ7
kernel:    ISA irqs (scanned) = 3,4,7,10 PCI status changes
kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean
kernel: xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
kernel: cs: IO probe 0x0100-0x04ff: excluding 0x378-0x37f

etc...


Thanks for any help,

	Regards,

		Marc
