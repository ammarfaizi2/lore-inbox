Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317295AbSFGOyC>; Fri, 7 Jun 2002 10:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317296AbSFGOyC>; Fri, 7 Jun 2002 10:54:02 -0400
Received: from [212.176.239.134] ([212.176.239.134]:42625 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317295AbSFGOyB>; Fri, 7 Jun 2002 10:54:01 -0400
Message-ID: <000701c20e33$1eb14450$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre10-ac2  PDC20265 IDE BUGS.
Date: Fri, 7 Jun 2002 18:53:43 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17GL7j-0000Nu-00*BIDtRFvcGFo* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.19-pre10-ac2 still has bugs in its promise 20265 ide controller driver.
I've got ide lost interrupt messages on console just in a few hours after
reboot. (BTW could someone explain me what does it means for drives in
UDMA100 mode?)
Below is a kernel.log messages:

>----------------------------
Jun  7 17:43:16 vzhik kernel: hdg: status timeout: status=0xd0 { Busy }
Jun  7 17:43:16 vzhik kernel:
Jun  7 17:43:16 vzhik kernel: hdg: drive not ready for command
Jun  7 17:43:16 vzhik kernel: hdg: status timeout: status=0xd0 { Busy }
Jun  7 17:43:16 vzhik kernel:
Jun  7 17:43:16 vzhik kernel: hdg: DMA disabled
Jun  7 17:43:17 vzhik kernel: ide3: reset: success
Jun  7 17:43:18 vzhik kernel: PDC202XX: Secondary channel reset.
Jun  7 17:43:18 vzhik kernel: hdg: drive not ready for command
Jun  7 17:43:38 vzhik kernel: hde: timeout waiting for DMA
Jun  7 17:44:03 vzhik kernel: PDC202XX: Primary channel reset.
Jun  7 17:44:03 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
func only: 16
Jun  7 17:44:03 vzhik kernel: hde: timeout waiting for DMA
Jun  7 17:44:03 vzhik kernel: PDC202XX: Primary channel reset.
Jun  7 17:44:03 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
func only: 16
Jun  7 17:44:03 vzhik kernel: hde: status timeout: status=0xd1 { Busy }
Jun  7 17:44:03 vzhik kernel:
Jun  7 17:44:03 vzhik kernel: PDC202XX: Primary channel reset.
Jun  7 17:44:03 vzhik kernel: hde: drive not ready for command
Jun  7 17:44:03 vzhik kernel: ide2: reset: success
Jun  7 17:49:21 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Jun  7 17:49:21 vzhik kernel:
Jun  7 17:49:21 vzhik kernel: hdg: drive not ready for command
Jun  7 17:49:21 vzhik kernel: hdg: status timeout: status=0xd0 { Busy }


