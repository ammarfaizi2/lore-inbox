Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSEBKnE>; Thu, 2 May 2002 06:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314343AbSEBKnD>; Thu, 2 May 2002 06:43:03 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1287 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314340AbSEBKnC>; Thu, 2 May 2002 06:43:02 -0400
Date: Thu, 2 May 2002 03:42:11 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] ide-2.4.19-p7.all.convert.8.patch piix_dmaproc/ide_dmaproc
In-Reply-To: <20020502095123.GA17480@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10205020341410.2107-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep, just found that screw ball of mine :-(

On Thu, 2 May 2002, Florian Lohoff wrote:

> 
> Hi,
> when running 2.4.19-pre7 + ide-2.4.19-p7.all.convert.8.patch i get
> a crash on booting while detection of the onboard IDE controller.
> 
> 00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 11) (prog-if 80 [Master])
> 	Subsystem: Siemens Nixdorf AG: Unknown device 0055
> 	Flags: bus master, medium devsel, latency 0
> 	I/O ports at 2400 [size=16]
> 
> Oops is a "Null pointer dereference at 00000040"
> EIP is "ide_dmaproc" + 1e
> Call trace "piix_dmaproc" "ide_register_subdriver" "idedisk_init" 
> 
> Decoded by hand. I tried with and with taskfile ..
> 
> Config snippet:
> 
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_IDE_TASKFILE_IO=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_PIIX_TUNING=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> Flo
> BTW: It seems linux/ide.h misses an include of linux/pci.h
> -- 
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>                         Heisenberg may have been here.
> 

Andre Hedrick
LAD Storage Consulting Group

