Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270694AbTGUT07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270695AbTGUT07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:26:59 -0400
Received: from webmail.insa-lyon.fr ([134.214.79.204]:40120 "EHLO
	mail.insa-lyon.fr") by vger.kernel.org with ESMTP id S270693AbTGUT0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:26:21 -0400
Date: Mon, 21 Jul 2003 21:41:21 +0200
From: Aurelien Jarno <aurel32@debian.org>
To: system_lists@nullzone.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE controler
Message-ID: <20030721194121.GA7490@pc.aurel32>
Mail-Followup-To: Aurelien Jarno <aurel32@debian.org>,
	system_lists@nullzone.org, linux-kernel@vger.kernel.org
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
X-Mailer: Mutt 1.5.4i (2003-03-19)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 06:15:32PM +0200, system_lists@nullzone.org wrote:
> 
> Hi there.
Hello,

>    I have a production server with a SiI680 pci device beeing used as a 
> IDE controler.

I am also using this IDE controller, but with a Compact Flash used as an
IDE disk.

[...]
> Jul 20 00:00:57 server01 kernel: hdf: dma_timer_expiry: dma status == 0x60
> Jul 20 00:00:57 server01 kernel: hdf: timeout waiting for DMA
> Jul 20 00:00:57 server01 kernel: hdf: timeout waiting for DMA
> Jul 20 00:00:57 server01 kernel: hdh: dma_timer_expiry: dma status == 0x61
> Jul 20 00:01:07 server01 kernel: hdh: timeout waiting for DMA
> Jul 20 00:01:07 server01 kernel: hdh: timeout waiting for DMA
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady SeekComplete Error }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { DriveStatusError }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady SeekComplete Error }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { DriveStatusError }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady SeekComplete Error }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { DriveStatusError }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady SeekComplete Error }
> Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { DriveStatusError }
> Jul 20 00:01:08 server01 kernel: hdg: DMA disabled
> Jul 20 00:01:09 server01 kernel: ide3: reset: success
> Jul 20 00:01:17 server01 kernel: hde: dma_timer_expiry: dma status == 0x21

I got exactly the same problems. At the beginning I thought it was due
to the compactflash which doesn't support DMA, but disabling it in the
kernel doesn't change anything.

The disk is usable, but sometimes at boot, everything is lost on the
disk (at least the ext3 partition is not recognized).

BTW, I've tried with a 2.6.0-test1 kernel, and it was not able to boot,
I have got a lot of "ide: lost interrupt", just after loading the SiI680
driver.

Cheers,
Aurelien
