Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272859AbTG3MYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272860AbTG3MYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:24:40 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:22477 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S272859AbTG3MYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:24:39 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2: SATA errors, not usable
Date: Wed, 30 Jul 2003 14:24:36 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307301424.36605.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing SATA with 2.6.0-test2 with a Intel P4 i875P chipset. The disk is 
recognised correcly, but right after trying any kind of access (hdparm, 
fdisk...) it starts to give the following errors:

...
ICH5-SATA: IDE controller at PCI slot 0000:00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xef90-0xef97, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef98-0xef9f, BIOS settings: hdg:pio, hdh:pio
hde: ST380013AS, ATA DISK drive
...
hde: max request size: 1024KiB
hde: host protected area => 1
hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(33)
 hde: hde1
...
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x40 { UncorrectableError }, LBAsect=70, high=0, low=70, 
sector=0
end_request: I/O error, dev hde, sector 0
Buffer I/O error on device hde, logical block 0
Buffer I/O error on device hde, logical block 1
Buffer I/O error on device hde, logical block 2
...


I tried it with 2.4.21 and 2.4.22-pre9 with the same results. 
Also changed the BIOS to put in "compatible mode" (as opposite to sata native) 
and got the same errors.

In all cases, the disk is unusable (a seagate barracuda 80GB).

Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

