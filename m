Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUCaJ0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCaJ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:26:15 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:13278 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S261884AbUCaJ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:26:09 -0500
Date: Wed, 31 Mar 2004 11:25:42 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: rmmod uhci-hcd hangs eternally (linux-2.6.5-rc2-bk8)
Message-ID: <20040331092542.GD28109@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When using linux-2.6.5-rc2-bk8, "rmmod uhci-hcd" hangs forever. Even
when trying a reboot, the machine won't reboot.

This happens with linux-2.6.5-rc2-bk8 on this hardware:

# lspci
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
0000:00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)

from dmesg:
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:04.2: UHCI Host Controller
uhci_hcd 0000:00:04.2: irq 5, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new full speed USB device using address 2

and with this hardware as well (also kernel 2.6.5-rc2-bk8):

# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 11)

from dmesg:
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. USB
uhci_hcd 0000:00:07.2: irq 9, io base 0000d400
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected


-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
