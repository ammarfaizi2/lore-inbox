Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUHBPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUHBPIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUHBPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:08:24 -0400
Received: from mail.aei.ca ([206.123.6.14]:8157 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265301AbUHBPIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:08:22 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Shane Shrybman <shrybman@aei.ca>
To: mingo@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091459297.2573.10.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 11:08:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was unable to boot -O2. It seemed to hang up when it got to the
aic7xxx(29160) scsi controller.

Boot messages copied by hand:

IRQ #16 thread started up.
delay 5 -10 secs
IRQ #19 thread started up.
delay 5 -10 secs
ahc_intr: HOST_MSG_LOOP bad phase 0x0
(repeats every 10-20 secs)
Waited a few minutes here before giving up and hitting reset.

Here is /proc/interrupts in 2.6.7-mm7
           CPU0       
  0:     740456    IO-APIC-edge  timer
  1:       1417    IO-APIC-edge  i8042
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:         14    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 16:        178   IO-APIC-level  ide3, EMU10K1
 17:       2491   IO-APIC-level  eth0
 19:      10335   IO-APIC-level  aic7xxx, bttv0, Bt87x audio
 21:      29074   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
 22:          0   IO-APIC-level  VIA8233
NMI:          0 
LOC:     740415 
ERR:          0
MIS:          0

Also, had to turn of parport in the config to get it to compile.

drivers/parport/share.c:77: unknown field `generic_enable_irq' specified
in initializer
drivers/parport/share.c:78: unknown field `generic_disable_irq'
specified in initializer

Regards,

Shane

