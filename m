Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287376AbSACWGm>; Thu, 3 Jan 2002 17:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287357AbSACWGd>; Thu, 3 Jan 2002 17:06:33 -0500
Received: from luke.cpl.net ([63.169.72.3]:59147 "EHLO luke.cpl.net")
	by vger.kernel.org with ESMTP id <S287420AbSACWGO>;
	Thu, 3 Jan 2002 17:06:14 -0500
Message-Id: <5.1.0.14.0.20020103134618.02eba540@mail.cpl.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 03 Jan 2002 14:03:05 -0800
To: linux-kernel@vger.kernel.org
From: Shawn Ramsey <shawn@cpl.net>
Subject: Firewire, SBP2 help
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running RedHat 7.2, trying to get an IDE drive with an Oxford 911
bridge to work. Its one of those Granite Digital hotswap bays... I tried
GDs Firewire card, didn't work, so got a firewiredirect.com card, since
it is listed as works "very well" on the IEEE1394 SourceForge site.
Although the chip on the card is different than listed on sourceforge...
TSB43AB22 is what is on the chip, but its an OHCI compliant card so it
"should" work. This is what I get after loading the modules :
ohci1394: v0.51 08/08/01 Ben Collins <<EMAIL: PROTECTED>>
PCI: Found IRQ 11 for device 00:0b.0
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ 3D[11] MMIO 3D[cfffd000-cfffd800]
Max Packet 3D
[2048]
ieee1394: Local host added: node 0:1023, GUID 000156000000095c
ieee1394: Device added: node 1:1023, GUID 0004da00e0012a8f
raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io 3D 1)
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
ieee1394: sbp2: sbp2_login_device failed
scsi0 : IEEE-1394 SBP-2 protocol driver

If I remove the HD, it detects it... here is the output after turning it
off, then back on :
ieee1394: ConfigROM quadlet transaction error for node 0:1023
ieee1394: ConfigROM quadlet transaction error for node 0:1023
ieee1394: ConfigROM quadlet transaction error for node 0:1023
ieee1394: Giving up on node 0:1023 for ConfigROM probe, too many errors
ieee1394: Node 0:1023 changed to 1:1023
ieee1394: Device removed: node 1:1023, GUID 0004da00e0012a8f
ieee1394: Node 1:1023 changed to 0:1023
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
ieee1394: sbp2: sbp2_login_device failed
ieee1394: Device added: node 1:1023, GUID 0004da00e0012a8f

Im not sure if this is the right place to send this, but the right place 
didn't give any answers... maybe there arn't any answers and this hardware 
combo just won't work... 

