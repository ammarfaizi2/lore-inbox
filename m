Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317120AbSEXPEA>; Fri, 24 May 2002 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317131AbSEXPD7>; Fri, 24 May 2002 11:03:59 -0400
Received: from [212.176.239.134] ([212.176.239.134]:46813 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317120AbSEXPD5>; Fri, 24 May 2002 11:03:57 -0400
Message-ID: <004101c20334$361b0b80$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8 ide bugs
Date: Fri, 24 May 2002 19:03:49 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17BGbe-0006Oj-00*EmAClf4OREI* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got the following problem with 2.4.19-pre8 &
ide-2.4.19-p7.all.convert.10.patch (w/o patch & I've more fatal problems
with sb & filesystem corruptions) kernel reports "kernel: bug: kernel timer
added twice at c01a7356." & panics.

Is it a known issue? What is the solution??? I remember that with 2.4.7 I
didn't have any ide errors... but it had reiserfs bugs...
Are there light at the end of ide nightmare?

Here is log:
>-------------------------------
May 24 12:19:48 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
May 24 12:19:48 vzhik kernel:
May 24 12:19:48 vzhik kernel: hdg: status timeout: status=0xd0 { Busy }
May 24 12:19:48 vzhik kernel:
May 24 12:19:49 vzhik kernel: hdg: DMA disabled
May 24 12:19:49 vzhik kernel: ide3: reset: success
May 24 12:19:49 vzhik kernel: PDC202XX: Secondary channel reset.
May 24 12:19:49 vzhik kernel: hdg: drive not ready for command
May 24 12:19:50 vzhik kernel: hde: timeout waiting for DMA
May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
May 24 12:19:50 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
func only: 16
May 24 12:19:50 vzhik kernel: hde: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
May 24 12:19:50 vzhik kernel: hde: dma_intr: error=0x84 { DriveStatusError
BadCRC }
May 24 12:19:50 vzhik kernel: hde: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
May 24 12:19:50 vzhik kernel: hde: dma_intr: error=0x84 { DriveStatusError
BadCRC }
May 24 12:19:50 vzhik kernel: hde: timeout waiting for DMA
May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
May 24 12:19:50 vzhik kernel: ide_dmaproc: chipset supported ide_dma_timeout
func only: 16
May 24 12:19:50 vzhik kernel: hde: status timeout: status=0xd1 { Busy }
May 24 12:19:50 vzhik kernel:
May 24 12:19:50 vzhik kernel: PDC202XX: Primary channel reset.
May 24 12:19:50 vzhik kernel: hde: drive not ready for command
May 24 12:19:50 vzhik kernel: ide2: reset: success
May 24 12:24:24 vzhik kernel: hdg: ide_set_handler: handler not null;
old=c01a5234, new=c01a5234
May 24 12:24:24 vzhik kernel: bug: kernel timer added twice at c01a7356.


