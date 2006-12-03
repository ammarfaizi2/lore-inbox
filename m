Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754282AbWLCVb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbWLCVb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760108AbWLCVb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:31:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:2037 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754282AbWLCVb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:31:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ev7vSTjRkVbuD6V9N0DG1K1WDalIHEvHaMQHihiOCxFC/JaI1wltLSYV2ixUOyeg4/Cp8XG46M0iUxNtoqwGS080dvzzFyZdQ3jZ//McFQElmEjelShHn6r3oF2yu7kqKnPnMhmKhaxK3BzIrwRXEY3IOQKYCpJtU7jsb6ipeBE=
Message-ID: <5a4c581d0612031331v478f7a21paf29665130282b1f@mail.gmail.com>
Date: Sun, 3 Dec 2006 22:31:25 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related
In-Reply-To: <5a4c581d0612031056r1eca228fp872276f3df7a07a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0612031056r1eca228fp872276f3df7a07a2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> FC6-latest running on a Latitude D610, SATA hard disk;
>  2.6.19 is okay, kernel built with oldconfig from the
>  known-working setup fails to boot not recognizing the
>  root partition, which is due to ata_piix not loading due
>  to a PCI I/O reserve error.
> Happens both with and without CONFIG_SYSFS_DEPRECATED
>  (I first had it to N then thought it might have had something
>  to do with the boot error so I rebuilt with Y - no change).
>
> Messages hand-copied from the screen on the 2nd try:
>
> Loading ata_piix.ko module
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> ata_piix: probe of 0000:00:1f.2 failed with error -16
> [snip]
> mount: could not find filesystem '/dev/root'

Same failure is also in 2.6.19-git4...

I'll download -git1 and -git2 to see which one broke my setup first.

> This is what is in the dmesg ring of 2.6.19:
>
>
> ata_piix 0000:00:1f.2: version 2.00ac6
> ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level,
> low) -> IRQ 5
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
> scsi0 : ata_piix
> ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA
> ata1.00: ata1: dev 0 multi count 8
> ata1.00: applying bridge limits
> ata1.00: configured for UDMA/100
> scsi1 : ata_piix
> ata2.00: ATAPI, max UDMA/33
> ata2.00: configured for UDMA/33

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
