Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWFURr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWFURr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWFURr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:47:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:13814 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932298AbWFURr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:47:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=SLjtX1V7ZGk8ugYtaPeu6Rea5ZnBq3GQD/j0AQM5OAU3mBMdFINmM+W4i+LOROBnbCsrmprwMTEQTAjL/F2bBeCWzzrSUs3cDWaihfPv9Dq6/rfWW9kFNioucyyd/nNOvWoxv6iA3fLvpQ3Dol4d1JLtq/4QclRd4rCmiwazIgg=
Message-ID: <170fa0d20606211047i532b5ec5mf17a028a9ed4e3a6@mail.gmail.com>
Date: Wed, 21 Jun 2006 13:47:27 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver for PDC202XX
Cc: Erik@echohome.org, linux-kernel@vger.kernel.org
In-Reply-To: <1150906236.15275.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_171327_13038139.1150912047263"
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
	 <1150887073.15275.34.camel@localhost.localdomain>
	 <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
	 <1150896840.15275.62.camel@localhost.localdomain>
	 <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
	 <1150898829.15275.69.camel@localhost.localdomain>
	 <170fa0d20606210820l5a41150bs7e8a088d85ca8d3b@mail.gmail.com>
	 <1150906236.15275.78.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_171327_13038139.1150912047263
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/21/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-06-21 am 11:20 -0400, ysgrifennodd Mike Snitzer:
> > ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata1: status=0x51 { DriveReady SeekComplete Error }
> > ata1: error=0x84 { DriveStatusError BadCRC }
>
> Thats a speed mistune somewhere in the code.
>
> Can you send me an lspci -vxx and the information on the drive (or
> dmesg) with a "normal" kernel boot and I'll hunt it down.

Please see attached for the lspci -vxx output.

Here is the the relevant IDE info from dmesg:

 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20267: IDE controller at PCI slot 0000:01:01.0
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:01.0[A] -> Link [LNKG] -> GSI 10 (level,
low) -> IRQ 10
PDC20267: chipset revision 2
PDC20267: ROM enabled at 0x40000000
PDC20267: 100% native mode on irq 10
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xdf00-0xdf07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xdf08-0xdf0f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP0401N, ATA DISK drive
ide0 at 0xdef0-0xdef7,0xdeea on irq 10
Probing IDE interface ide1...
ICH5: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level,
low) -> IRQ 5
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xffa8-0xffaf, BIOS settings: hde:DMA, hdf:pio
Probing IDE interface ide2...
hde: GCR-8483B, ATAPI CD/DVD-ROM drive
ide2 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide1...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 78125000 sectors (40000 MB)
        native  capacity is 78242976 sectors (40060 MB)
hda: Host Protected Area disabled.
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3


also smartctl info:

=== START OF INFORMATION SECTION ===
Device Model:     SAMSUNG SP0401N
Serial Number:    S004J10Y647557
Firmware Version: TJ100-28
User Capacity:    40,060,403,712 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Wed Jun 21 13:45:56 2006 EDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

------=_Part_171327_13038139.1150912047263
Content-Type: application/x-gzip; name=lspci.txt.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eopz299m
Content-Disposition: attachment; filename="lspci.txt.gz"

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
AAA=
------=_Part_171327_13038139.1150912047263--
