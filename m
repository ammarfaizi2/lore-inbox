Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTAaXcu>; Fri, 31 Jan 2003 18:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTAaXcu>; Fri, 31 Jan 2003 18:32:50 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:1696 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S263366AbTAaXcs>; Fri, 31 Jan 2003 18:32:48 -0500
Message-ID: <8291418.1044056227743.JavaMail.nobody@web11.us.oracle.com>
Date: Fri, 31 Jan 2003 15:37:07 -0800 (GMT-08:00)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: irda-users@lists.sourceforge.net
Subject: 2.4.21-pre4 / IrDA on a Dell C640, still no go
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a bit more time to try the smsc-ircc2 driver, but as
 its predecessor it fails to find an irq for the chip
 (LPC47N252), printing out

IrCC version 2.0, firport 0x290, sirport 0x3e8, dma=3, irq=0

I tried booting into Win2K, where the driver claims to be using
 irq 3, rebooted in 2.4.21-pre4, said

[root@incident root]# insmod smsc-ircc2 ircc_irq=3

 but apart from getting a printk saying

smsc-ircc2, Overriding IRQ - chip says 0, using 3

I still see nothing doing irdadump, and /proc/interrupts only
 shows these:

  0:   324401      XT-PIC  timer
  1:     3592      XT-PIC  keyboard
  2:        0      XT-PIC  cascade
  9:        5      XT-PIC  acpi
 11:        0      XT-PIC  Intel ICH3, Texas Instruments PCI1420,
       Texas Instruments PCI1420 (#2), usb-uhci
 12:        6      XT-PIC  PS/2 Mouse
 14:     3987      XT-PIC  ide0
 15:        0      XT-PIC  ide1

There is no option in the Dell BIOS to choose an IRQ for the
 IR chip (as it isn't there in this CPx750J, but this one works
 just fine on irq 4).


Any suggestion on how to go on from here is welcome !


Thanks, ciao,

--alessandro
