Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQL3Xz5>; Sat, 30 Dec 2000 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQL3Xzh>; Sat, 30 Dec 2000 18:55:37 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:1723 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129348AbQL3Xzd>; Sat, 30 Dec 2000 18:55:33 -0500
Date: Sat, 30 Dec 2000 23:24:40 +0000 (GMT)
From: davej@suse.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: linux-usb-devel@lists.sourceforge.net
Subject: Problems with ov511/USB on test13-pre7
Message-ID: <Pine.LNX.4.21.0012302312580.13297-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 Problems with Creative Webcam III. This worked fine
in test13-pre4, haven't tried pre5 & 6.

On boot:

 usb_control/bulk_msg: timeout
 usb_control/bulk_msg: timeout
 usb.c: couldn't get all of config descriptors
 usb.c: unable to get device 2 configuration (error=-110)
 hub.c: USB new device connect on bus1/1, assigned device number 4
 usb_control/bulk_msg: timeout
 usb.c: USB device not accepting new address=4 (error=-110)

On remove/reinsert:

 hub.c: USB new device connect on bus1/1, assigned device number 5
 usb_control/bulk_msg: timeout
 usb.c: USB device not accepting new address=5 (error=-110)
 hub.c: USB new device connect on bus1/1, assigned device number 6
 usb_control/bulk_msg: timeout
 usb.c: USB device not accepting new address=6 (error=-110)

USB controller is:

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The only other thing of relevance in dmesg, is the flood of
irq warnings related to the two USB controllers on 4.2 & 4.3 :-

 PCI: Found IRQ 5 for device 00:09.0
 PCI: The same IRQ used for device 00:04.2
 PCI: The same IRQ used for device 00:04.3
 PCI: Found IRQ 5 for device 00:04.2
 PCI: The same IRQ used for device 00:04.3
 PCI: The same IRQ used for device 00:09.0
 PCI: Found IRQ 5 for device 00:04.3
 PCI: The same IRQ used for device 00:04.2
 PCI: The same IRQ used for device 00:09.0
 usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5
 usb-uhci.c: Detected 2 ports
 hub.c: USB new device connect on bus1/1, assigned device number 2
 usb.c: new USB bus registered, assigned bus number 2
 usb-uhci.c: interrupt, status 2, frame# 135
 hub.c: USB hub found
 hub.c: 2 ports detected
 usb.c: registered new driver ov511
 ov511.c: ov511 driver version 1.28 registered

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
