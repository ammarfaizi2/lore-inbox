Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTEMPtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTEMPtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:49:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31656 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261702AbTEMPtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:49:17 -0400
Date: Tue, 13 May 2003 06:47:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 712] New: USB device not accepting new address.
Message-ID: <24740000.1052833661@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: USB device not accepting new address.
    Kernel Version: 2.5.69-bk8
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: davej@codemonkey.org.uk


Booting up with an ov511 camera attached, the camera isn't detected.

uhci-hcd 00:07.2: VIA Technologies, In USB
uhci-hcd 00:07.2: irq 11, io base 0000c400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Found IRQ 11 for device 00:07.3
PCI: Sharing IRQ 11 with 00:07.2
PCI: Sharing IRQ 11 with 00:09.0
PCI: Sharing IRQ 11 with 00:11.0
uhci-hcd 00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 00:07.3: irq 11, io base 0000c800
uhci-hcd 00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver


unplugging, and replugging the camera does this...

hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 4
usb 1-2: USB device not accepting new address=4 (error=-110)
hub 1-0:0: new USB device on port 2, assigned address 5
usb 1-2: USB device not accepting new address=5 (error=-110)

This worked up until very recently. (Maybe even in 2.5.69)


