Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbTILLSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbTILLSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:18:21 -0400
Received: from e450.rm.cnr.it ([150.146.1.17]:17372 "EHLO e450.rm.cnr.it")
	by vger.kernel.org with ESMTP id S261207AbTILLST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:18:19 -0400
Date: Fri, 12 Sep 2003 13:27:15 +0200
From: flavio <flavio.l@tiscali.it>
Subject: Re: PROBLEM:SCSI repeatable 2.4.22 bug
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3F61AD93.4050803@tiscali.it>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
 Netscape/7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mer, 2003-09-10 at 13:39, flavio wrote:
>> Hi,
>>
>> the hd and dvd light are constantly on from boot onwards (using vanilla
>> 2.4.22 and the /var/log/messages is a sequence of messages as in
>> attachment).
>> 2.4.20 vanilla has no problems whatsoever...
> 
> Your drive is returning more data than it was asked for or expected.
> What model drives do you have and does turning off DMA for non disk fix
> it ?

I recompiled 2.4.22 with the following changes:
dma off and verbose scsi

< # CONFIG_BLK_DEV_IDEDMA_PCI is not set
< # CONFIG_IDEDMA_PCI_AUTO is not set
< # CONFIG_BLK_DEV_IDEDMA is not set
< # CONFIG_BLK_DEV_PIIX is not set
< # CONFIG_IDEDMA_AUTO is not set
< CONFIG_SR_EXTRA_DEVS=6
< CONFIG_SCSI_CONSTANTS=y
< CONFIG_SCSI_LOGGING=y

All I got was a hard freeze shortly after opening a shell in X

Please let me know if I can help further

TIA

Flavio Lombardi

log/messages shows:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Sep 11 19:27:10 gundam kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Sep 11 19:27:10 gundam kernel: hda: IC25N030ATCS04-0, ATA DISK drive
Sep 11 19:27:10 gundam kernel: hdc: TOSHIBA DVD-ROM SD-R2212, ATAPI 
CD/DVD-ROM drive
Sep 11 19:27:10 gundam kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 11 19:27:10 gundam kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 11 19:27:10 gundam kernel: hda: attached ide-disk driver.
Sep 11 19:27:10 gundam kernel: hda: host protected area => 1
Sep 11 19:27:10 gundam kernel: hda: 58605120 sectors (30006 MB) 
w/1768KiB Cache, CHS=3648/255/63
Sep 11 19:27:10 gundam kernel: Partition check:
Sep 11 19:27:10 gundam kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 
< p5 p6 p7 p8 p9 p10 p11 p12 >
...
Sep 11 19:27:10 gundam kernel: hdc: attached ide-scsi driver.
Sep 11 19:27:10 gundam kernel: scsi0 : SCSI host adapter emulation for 
IDE ATAPI devices
Sep 11 19:27:10 gundam kernel:   Vendor: TOSHIBA   Model: DVD-ROM 
SD-R2212  Rev: 1F15
Sep 11 19:27:10 gundam kernel:   Type:   CD-ROM 
     ANSI SCSI revision: 02


