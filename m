Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271130AbRHTI0Y>; Mon, 20 Aug 2001 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271134AbRHTI0P>; Mon, 20 Aug 2001 04:26:15 -0400
Received: from [203.161.228.202] ([203.161.228.202]:12294 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S271135AbRHTIZ5>; Mon, 20 Aug 2001 04:25:57 -0400
Date: 20 Aug 2001 08:36:30 -0000
Message-ID: <20010820083630.16182.qmail@yusufg.portal2.com>
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 2.4.8 and 2.4.9 have no problems compiling and booting on a P3 500
440GX mobo (APIC not compiled in the kernel)

With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
compile with APIC enabled and APIC on UP also enabled, it boots
cleanly

booting with append="noapic", gives the same errors


SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:0c.1
PCI: Found IRQ 11 for device 00:0c.1
PCI: Sharing IRQ 11 with 00:0c.0

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs

scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195
scsi0:0:0:0: Attempting to queue a TARGET RESET message
aic7xxx_dev_reset returns 8195
Recovery SCB completes
scsi0:0:0:0: Attempting to queue an ABORT message
ahc_intr: HOST_MSG_LOOP bad phase 0x0
scsi0:0:0:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Command already completed
aic7xxx_abort returns 8194
scsi0:0:1:0: Attempting to queue a TARGET RESET message
scsi0:0:1:0: Is not an active device
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0:0:1:0: Command already completed
aic7xxx_abort returns 8194

Regards, Yusuf
