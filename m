Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755349AbWKMU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbWKMU7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbWKMU7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:59:17 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:42202 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1755349AbWKMU7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:59:16 -0500
Message-ID: <4558DCA0.7070800@scientia.net>
Date: Mon, 13 Nov 2006 21:59:12 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net>	<20061110135649.16cccca0.vsu@altlinux.ru>	<4557AF26.8030007@scientia.net> <20061113000120.09fd6174@localhost.localdomain>
In-Reply-To: <20061113000120.09fd6174@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------020101050703050903000800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101050703050903000800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alan wrote:
>> Can anybody imagine that DMA could cause my problems? And if so,.. is it
>> likely that this would come from a hardware error or maybe from software?
>>     
>
> IDE DMA hits the hardware pretty heavily, so it may show up PCI
> arbitration bugs, software bugs handling PCI stalls in other drivers
> and/or BIOS misconfiguration of system parameters
And what should I do now?



Anyway here my current testing results:
As I told in the beginning I have the following configuration:

primary IDE controller:
master: my pata harddisk
slave: Plextor PX760A (DVD/CD)

secondary IDE controller (not usable with the board - no connectors at
all ;) )

SATA controller:
2x harddisks


Ok yesterday I've reported that when using_dma:0 for the PATA disk,..
the error doesn't occur (I did three or four diffs of the 30 GB).
I still don't know how to deactivate DMA for SATA... so wasn't able to
test the same thing on the SATA drives.

dmes says the following for my IDE devices:
Probing IDE interface ide0...
hda: IC35L120AVV207-1, ATA DISK drive
hdb: PLEXTOR DVDR PX-760A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20


As the CD/DVD runs in DMA, too (but a slower, UDMA66), I took a full
DualLayer Disk, created sha512sums of all files,.. and verified them
some times (4x).
No checksum mismatch was found, what does this mean now?

If I assume that the whole error is driver related, then wouldn't this
apply to the CD/DVD drive, too? The same if it would be an hardware error?

The driver I use is the AMD7XXX,... while it says that it work for some
nvidia (IIRC up to nforce 3) chipsets, too, does it also work for the
nforce professional?


Ok another idea was,.. that the errors come from some electro-magnetical
disturbances or something like that,... does this sound possible?
At least my IDE cables are shielded,...

Best wishes,
Chris.

--------------020101050703050903000800
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------020101050703050903000800--
