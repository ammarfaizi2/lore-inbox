Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCTJ3a>; Tue, 20 Mar 2001 04:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCTJ3K>; Tue, 20 Mar 2001 04:29:10 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:49366 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S129282AbRCTJ3C>;
	Tue, 20 Mar 2001 04:29:02 -0500
Date: Tue, 20 Mar 2001 10:28:06 +0100 (CET)
From: Wouter Verhelst <wouter.verhelst@advalvas.be>
To: linux-kernel@vger.kernel.org
Subject: CDROM and harddisk fighting over DMA
Message-ID: <Pine.LNX.4.21.0103201018080.370-100000@rock.dezevensprong.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm not subscribed to linux-kernel, so please CC any answers. TIA)

Hello

Since I bought my new harddisk (a Maxtor 40GB of about a half year old
now), I've had errors over my console like this:

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }

hda is my harddisk. The CDROM was first connected to hdb, but I changed
that to hdc, trying to get rid of these errors. This did not resolve the
issue.
After playing around a bit, I found out that these errors occur when both
the CDROM and the harddisk are being accessed at the same time (well,
almost; it's not an SMP system ;-). I managed to fix it by disabling DMA 
on the harddisk, using hdparm. Disabling DMA on the CDROM, by contrast,
did not resolve the issue.

However, as this slows down my data throughput speed quite drastically,
I'd like to do this differently.

I first posted this to comp.os.linux.setup, but did not get any useful
information. I believe it's not some misconfiguration from my side, so I
sent this here since this mailinglist is listed as relevant mailinglist
for the IDE subsystem; however, if this is the wrong place to ask, please
redirect.

-- 
wouter dot verhelst at advalvas in belgium

Real men don't take backups.
They put their source on a public FTP-server and let the world mirror it.
					-- Linus Torvalds

