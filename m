Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSF0OY3>; Thu, 27 Jun 2002 10:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSF0OY2>; Thu, 27 Jun 2002 10:24:28 -0400
Received: from ns.tasking.nl ([195.193.207.2]:21010 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S316856AbSF0OY1>;
	Thu, 27 Jun 2002 10:24:27 -0400
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ATA: cleanup of channel->autodma flags usage
In-Reply-To: <Pine.SOL.4.30.0206252129130.27820-200000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0206252129130.27820-200000@mion.elka.pw.edu.pl>
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 27 Jun 2002 16:23:02 +0200
Message-ID: <siit443int.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

Bartlomiej> incremental to generic ATA PCI auto-dma patches...
[...]
Bartlomiej> 	- remove ATA_F_NOAUTODMA flag from aec62xx.c, hpt34x.c,
Bartlomiej> 	  sis5513.c and via82cxxx.c drivers, it's use was bogus
Bartlomiej> 	  in these drivers

Bartlomiej> 	  only two usages of ATA_F_NOAUTODMA are left (in ide-pci.c),
Bartlomiej> 	  probably they can alse be removed due to fact that drivers
Bartlomiej> 	  should disable autodma not ide-pci (i.e. hpt34x)
[...]

That should say: ATA_F_NOADMA

I have removed ATA_F_NODMA in ide-pci.c for my VIA8233
(PCI_DEVICE_ID_VIA_82C586_1). So far it has not failed (using 2.5.20).

--- linux-2.5.20/drivers/ide/ide-pci.c~	Mon Jun  3 14:49:59 2002
+++ linux-2.5.20/drivers/ide/ide-pci.c	Fri Jun  7 18:52:50 2002
@@ -742,8 +742,7 @@
 	{
 		vendor: PCI_VENDOR_ID_VIA,
 		device: PCI_DEVICE_ID_VIA_82C586_1,
-		bootable: ON_BOARD,
-		flags: ATA_F_NOADMA
+		bootable: ON_BOARD
 	},
 	{
 		vendor: PCI_VENDOR_ID_TTI,

- Kees
