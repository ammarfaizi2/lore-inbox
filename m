Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUKDCO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUKDCO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUKDCNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:13:54 -0500
Received: from tueddeln.de ([217.160.187.172]:3734 "EHLO
	p15131177.pureserver.info") by vger.kernel.org with ESMTP
	id S262055AbUKDCEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:04:09 -0500
Message-ID: <41898E16.8090908@babut.net>
Date: Thu, 04 Nov 2004 03:04:06 +0100
From: Thomas Babut <thomas@babut.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Adapter
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm trying to run a Kernel 2.6 on the following machine:

Debian Sarge 3.1 with newest updates
gcc version 3.3.4 (Debian 1:3.3.4-13)

Dual Pentium III at 1000 MHz with 1 GByte RAM and Quantum ATLAS10K2-TY367J

Output from lspci:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
0000:00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
South] (rev 40)
0000:00:04.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 16)
0000:00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 16)
0000:00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super 
ACPI] (rev 40)
0000:00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 
100] (rev 08)
0000:00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 
Ultra3 SCSI Adapter (rev 01)
0000:00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 
Ultra3 SCSI Adapter (rev 01)
0000:00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21152 
(rev 03)
0000:02:0c.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
86C326 5598/6326 (rev 0b)

On boot it hangs with following messages:

sym0: <1010-33> rev 0x1 at pci 0000:00:08.1 irq 169
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
Vendor: QUANTUM   Model: ATLAS10K2-TY367J  Rev: DDD6
Type: Direct-Access ANSI SCSI revision: 03
sym0:1:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:1:0): Beginning Domain Validation
sym0:1: wide asynchronous.
sym0:1:0: ABORT operation started.
sym0:1:0: ABORT operation timed-out.
sym0:1:0: DEVICE RESET operation started.
sym0:1:0: DEVICE RESET operation timed-out.
sym0:1:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0: SCSI BUS operation completed.

At this point only a hard-reset helps.

With Kernel 2.4.26 and 2.4.27 it runs without any problems. I've tried 
almost every Kernel 2.6:
2.6.5 (vanilla), 2.6.9 (vanilla), 2.6.10-rc1-bk13, 2.6.10-rc1-mm2, 2.6.8 
(Debian Sources), 2.6.9 (Debian Sources)

It seems that this problem is not new or not unknown, but I didn't find 
a solution yet.

Best Regards,
Thomas
