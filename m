Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUBSVfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:35:46 -0500
Received: from mid-1.inet.it ([213.92.5.18]:45214 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S267573AbUBSVe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:34:56 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.3-mm1 and aic7xxx
Date: Thu, 19 Feb 2004 22:34:53 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200402192234.53855.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing some problems with 2.6.3-mm1 release: on boot the system 
hangs trying to detect scsi devices, and the light on scsi cdrom flashes 
every few seconds. With 2.6.3-rc3-mm1 all works just fine, and I get this 
syslog entry:

Feb 19 22:23:15 kefk kernel: ahc_pci:3:6:0: Host Adapter Bios disabled.  Using 
default SCSI device parameters
Feb 19 22:23:15 kefk kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
DRIVER, Rev 6.2.36
Feb 19 22:23:15 kefk kernel:         <Adaptec 2902/04/10/15/20C/30C SCSI 
adapter>
Feb 19 22:23:15 kefk kernel:         aic7850: Single Channel A, SCSI Id=7, 
3/253 SCBs

<<<<<<<<<<<<<<<2.6.3-mm1 hangs here

Feb 19 22:23:15 kefk kernel:
Feb 19 22:23:15 kefk kernel:   Vendor: Nikon     Model: COOLSCANIII       Rev: 
1.31
Feb 19 22:23:15 kefk kernel:   Type:   Scanner                            ANSI 
SCSI revision: 02
Feb 19 22:23:15 kefk kernel: (scsi0:A:3): 10.000MB/s transfers (10.000MHz, 
offset 15)
Feb 19 22:23:15 kefk kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 
1.01
Feb 19 22:23:15 kefk kernel:   Type:   CD-ROM                             ANSI 
SCSI revision: 02
Feb 19 22:23:15 kefk kernel: (scsi0:A:5): 10.000MB/s transfers (10.000MHz, 
offset 15)
Feb 19 22:23:15 kefk kernel:   Vendor: YAMAHA    Model: CRW6416S          Rev: 
1.0c
Feb 19 22:23:15 kefk kernel:   Type:   CD-ROM                             ANSI 
SCSI revision: 02

I've also noticed (only with 2.6.3-mm1) a "PCI BIOS passed non existent PCI 
BUS 0!" message when it probes ICH5, i.e.

Feb 19 22:23:15 kefk kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1

<<<<<<<<<<<<HERE

Feb 19 22:23:15 kefk kernel: ICH5: chipset revision 2
Feb 19 22:23:15 kefk kernel: ICH5: not 100%% native mode: will probe irqs 
later
Feb 19 22:23:15 kefk kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: 
hda:DMA, hdb:pio
Feb 19 22:23:15 kefk kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: 
hdc:pio, hdd:pio

system: PIV 2.HT/i875p (abit ic7-g), SMP kernel (SMT), 
gcc (GCC) 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk)

I can provide more details if needed, and any help will be appreciated.

Thanks.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
