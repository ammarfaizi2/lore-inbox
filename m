Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRHTIzk>; Mon, 20 Aug 2001 04:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270600AbRHTIza>; Mon, 20 Aug 2001 04:55:30 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:44080 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S270031AbRHTIzR>; Mon, 20 Aug 2001 04:55:17 -0400
Date: Mon, 20 Aug 2001 10:55:20 +0200
From: Cliff Albert <cliff@oisec.net>
To: Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820105520.A22087@oisec.net>
In-Reply-To: <20010820083630.16182.qmail@yusufg.portal2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010820083630.16182.qmail@yusufg.portal2.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 08:36:30AM -0000, Yusuf Goolamabbas wrote:

> Hi, 2.4.8 and 2.4.9 have no problems compiling and booting on a P3 500
> 440GX mobo (APIC not compiled in the kernel)
> 
> With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
> compile with APIC enabled and APIC on UP also enabled, it boots
> cleanly

I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
i've been getting these errors since 2.4.3.

> booting with append="noapic", gives the same errors

This also didn't resolve my problems

> SCSI subsystem driver Revision: 1.00
> PCI: Assigned IRQ 11 for device 00:0c.0
> PCI: Sharing IRQ 11 with 00:0c.1
> PCI: Found IRQ 11 for device 00:0c.1
> PCI: Sharing IRQ 11 with 00:0c.0
> 
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>         <Adaptec aic7896/97 Ultra2 SCSI adapter>
>         aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
> 
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
>         <Adaptec aic7896/97 Ultra2 SCSI adapter>
>         aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/255 SCBs

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 14 for device 00:06.0
PCI: Sharing IRQ 14 with 00:04.2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
	aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

> 
> scsi0:0:0:0: Attempting to queue an ABORT message
> scsi0:0:0:0: Command already completed
> aic7xxx_abort returns 8194
> scsi0:0:0:0: Attempting to queue an ABORT message
> scsi0:0:0:0: Device is active, asserting ATN
> Recovery code sleeping
> Recovery code awake
> Timer Expired
> aic7xxx_abort returns 8195
> scsi0:0:0:0: Attempting to queue a TARGET RESET message
> aic7xxx_dev_reset returns 8195
> Recovery SCB completes
> scsi0:0:0:0: Attempting to queue an ABORT message
> ahc_intr: HOST_MSG_LOOP bad phase 0x0
> scsi0:0:0:0: Cmd aborted from QINFIFO
> aic7xxx_abort returns 8194
> scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0
> scsi0:0:1:0: Attempting to queue an ABORT message
> scsi0:0:1:0: Command already completed
> aic7xxx_abort returns 8194
> scsi0:0:1:0: Attempting to queue an ABORT message
> scsi0:0:1:0: Command already completed
> aic7xxx_abort returns 8194
> scsi0:0:1:0: Attempting to queue a TARGET RESET message
> scsi0:0:1:0: Is not an active device
> scsi0:0:1:0: Attempting to queue an ABORT message
> scsi0:0:1:0: Command already completed
> aic7xxx_abort returns 8194

scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 1 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 4 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 2 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 9 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 0 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command not found
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
scsi0:0:0:0: Command found on device queue
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
(scsi0:A:0:0): Abort Tag Message Sent
Recovery code sleeping
(scsi0:A:0:0): SCB 11 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 6 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue an ABORT message
(scsi0:A:0:0): Queuing a recovery SCB
scsi0:0:0:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:0:0): Abort Tag Message Sent
(scsi0:A:0:0): SCB 3 - Abort Tag Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 8194
scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 8194
Device not ready.  Make sure there is a disc in the drive.
Device not ready.  Make sure there is a disc in the drive.

SCSI device listing is:

  Vendor: QUANTUM   Model: FIREBALL ST6.4S   Rev: 0F0C
    Type:   Direct-Access                      ANSI SCSI revision: 02
    (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
    Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0H
    Type:   CD-ROM                             ANSI SCSI revision: 02
    (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 7)
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.01
    Type:   CD-ROM                             ANSI SCSI revision: 02
    (scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)


-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
