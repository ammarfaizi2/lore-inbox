Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTEOWsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEOWsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:48:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23254 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264277AbTEOWsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:48:06 -0400
Date: Thu, 15 May 2003 15:50:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 725] New: Between 2.5.68bk4 and bk5 usb stopped getting interrupt with acpi 
Message-ID: <10730000.1053039011@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=725

           Summary: Between 2.5.68bk4 and bk5 usb stopped getting interrupt
                    with acpi
    Kernel Version: 2.5.68-bk5
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: stian_web@jordet.nu


Distribution: Debian Sid
Hardware Environment: Asus CUV266-DLS Dual P3
Software Environment: 
Problem Description:
With 2.5.68bk5 usb don't get any interrupts anymore. This has been working
flawlessly untill bk5. When I diff dmesg from the two kernels, I get this:

+IOAPIC[0]: Set PCI routing entry (2-11 -> 0x81 -> IRQ 11)
+00:00:11[A] -> 2-11 -> IRQ 11
+IOAPIC[0]: Set PCI routing entry (2-10 -> 0x79 -> IRQ 10)
+00:00:11[B] -> 2-10 -> IRQ 10
+IOAPIC[0]: Set PCI routing entry (2-5 -> 0x51 -> IRQ 5)
+00:00:11[C] -> 2-5 -> IRQ 5
+IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
+00:00:11[D] -> 2-9 -> IRQ 9

This is there only with bk5, not bk4. Don't know if this as anything to do with it. 

Part of /proc/interrupts

With bk5 
  9:          0          0   IO-APIC-level  acpi, uhci-hcd, uhci-hcd, uhci-hcd
with bk4:
  9:        268          1   IO-APIC-level  acpi, uhci-hcd, uhci-hcd, uhci-hcd

Thanks you.


