Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTKWGcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 01:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTKWGcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 01:32:18 -0500
Received: from fmr03.intel.com ([143.183.121.5]:17588 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263299AbTKWGcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 01:32:17 -0500
Subject: Re: irq 9: nobody cared! on 2.6.0-test9
From: Len Brown <len.brown@intel.com>
To: Darren Dupre <darren@dmdtech.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184C9EB@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184C9EB@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069569132.3254.69.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Nov 2003 01:32:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3]
trigger[0x3])

This requests level/low for SCI on IRQ9

> IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1
Active:1)

This indicates that we set IRQ9 to level/low, as requested.

Though 2.6.0 lacks the print_IO_APIC patch, so you'd need to apply this
and re-collect dmesg to really confirm the IOAPIC is programmed
correctly:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.0-test9/

If you boot with pci=noacpi, does the system run properly (including
/proc/interrupts showing ACPI interrupts when you, say, press the power
button)

> http://bugme.osdl.org/show_bug.cgi?id=1352

Though I'd love to be wrong, I think this one is a different failure. 
Please file a new one per below.  Would also be good to verify that the
latest 2.4 kernel does the same thing.

thanks,
-Len

How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here:
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


