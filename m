Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129975AbRAWR3H>; Tue, 23 Jan 2001 12:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRAWR25>; Tue, 23 Jan 2001 12:28:57 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:62726
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129975AbRAWR2o>; Tue, 23 Jan 2001 12:28:44 -0500
Date: Tue, 23 Jan 2001 09:28:34 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andy Galasso <andy@adgsoftware.com>
cc: "David D.W. Downey" <pgpkeys@hislinuxbox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
In-Reply-To: <20010120033950.A16350@adgsoftware.com>
Message-ID: <Pine.LNX.4.10.10101230924510.10071-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001, Andy Galasso wrote:

> I'm not sure how relevant it is, but FWIW here's what I've got:
> 
> MSI 694D Pro Motherboard 2xPIII-800 100MHz FSB
> Linux-2.4.0-prerelease SMP
> Promise FastTrak100 controller card
> 4 IBM DTLA-307030 drives attached to Promise card
> boot params: ide2=0xac00 ide3=0xb400

DON'T the above silly "ide2=0xac00 ide3=0xb400"!

> hde: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
> hdf: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
> hdg: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
> hdh: probing with STATUS(0x50) instead of ALTSTATUS(0xff)

You have no altstatus register because of using 2.2 crippled access on 2.4
fully enabled.

> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xac00-0xac07,0xae06 on irq 16
> ide3 at 0xb400-0xb407,0xb606 on irq 16 (shared with ide2)

You have now lost your interrupt parser in the driver :-(

>  hde:hde: irq timeout: status=0x50 { DriveReady SeekComplete }

No one is to every override the driver on setting up the IO base.

Cheers,


Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
