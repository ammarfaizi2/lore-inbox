Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293701AbSCKWuf>; Mon, 11 Mar 2002 17:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSCKWsX>; Mon, 11 Mar 2002 17:48:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293547AbSCKWsD>; Mon, 11 Mar 2002 17:48:03 -0500
Subject: Re: Linux 2.4.19-pre3
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Mon, 11 Mar 2002 23:03:22 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3C8D3265.146899B1@eyal.emu.id.au> from "Eyal Lebedinsky" at Mar 12, 2002 09:40:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kYp8-000233-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> aec62xx.o alim15x3.o amd74xx.o cmd640.o cmd64x.o cs5530.o cy82c693.o
> hpt34x.o hpt366.o ide-adma.o ide-dma.o ide-pci.o ns87415.o opti621.o
> serverworks.o pdc202xx.o pdcadma.o piix.o rz1000.o sis5513.o slc90e66.o
> trm290.o via82cxxx.o ide-proc.o
> ld: cannot open pdcadma.o: No such file or directory

Interesting. That option should not be selectable. Try this

--- drivers/ide/Config.in~	Sat Mar  2 00:49:03 2002
+++ drivers/ide/Config.in	Mon Mar 11 22:43:57 2002
@@ -82,7 +82,7 @@
 	    fi
 	    dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
-	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP $CONFIG_EXPERIMENTAL
+#	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP $CONFIG_EXPERIMENTAL
 	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
 	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
