Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbQKKKOl>; Sat, 11 Nov 2000 05:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbQKKKOb>; Sat, 11 Nov 2000 05:14:31 -0500
Received: from pop.gmx.net ([194.221.183.20]:52343 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129359AbQKKKOR>;
	Sat, 11 Nov 2000 05:14:17 -0500
From: Gerald Haese <Gerald.Haese@gmx.de>
Reply-To: Gerald.Haese@gmx.de
Organization: GMX
Date: Sat, 11 Nov 2000 11:19:47 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Greg KH <greg@wirex.com>
In-Reply-To: <00111101012003.01860@dose> <20001110164006.E1229@wirex.com>
In-Reply-To: <20001110164006.E1229@wirex.com>
Subject: Re: USB mouse stops working
MIME-Version: 1.0
Message-Id: <00111111194700.00657@dose>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 11. November 2000 01:40 schrieb Greg KH:

>> I'm using an SMP system. Everything works fine and (absolutely) stable -
>> exept my USB mouse :-( It's the USB version of the Wacom Graphire tablet.
>> The mouse works great for some minutes or up to half an hour and it
>> generates a lot of interrupts during this time ... And now the mouse stops
>> working. No interrupt is generated. The USB printer does not work any
>> more. Unloading and reloading of the USB related modules does not help :-(
>> No interrupts are registered for USB (seen in /proc/interrupts).

> What is the output of /proc/interrupts?  Is USB sharing an interrupt
> with anything else?

Here it is:

           CPU0       CPU1
  0:      48988      28737    IO-APIC-edge  timer
  1:        457        276    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  7:          2          0    IO-APIC-edge  parport0
  8:          0          2    IO-APIC-edge  rtc
  9:       1085        968    IO-APIC-edge  HiSax
 13:          0          0          XT-PIC  fpu
 16:         11         10   IO-APIC-level  aic7xxx
 18:      14845      14797   IO-APIC-level  usb-uhci
 19:       2982       3028   IO-APIC-level  aic7xxx
NMI:      77639      77638 
LOC:      77623      77619 
ERR:          1

I have a PCI USB board with a uhci compliant (I hope so) VIA chip.


Gerald
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
