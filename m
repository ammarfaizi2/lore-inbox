Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWHHScu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWHHScu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHHScu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:32:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:43993 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWHHSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:32:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NSqyutw2eU2f9iZPD3NdYDr75tOukbpWCC6yCASMCBKcBiTvE5w0b4cNZKt9BkySMtrOnFMNvy7yTzxL3whmkMhFwjONajREt+VPW0NbmZE4qFpZtn8/OWLhJnx7df1qtbGnH2xT5YG/IvlYAXEuULh6Y1De4KDRMLiGnNjZoik=
Message-ID: <b1bc6a000608081132p2178caa3sd0c9e12813e28ef2@mail.gmail.com>
Date: Tue, 8 Aug 2006 11:32:40 -0700
From: "adam radford" <aradford@gmail.com>
To: "Andy Davidson" <andy@nosignal.org>
Subject: Re: 3ware 9550 using 3w-9xxx driver lockups ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D89D5D.1000808@nosignal.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D89D5D.1000808@nosignal.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks to me like you have a bad drive (or several bad drives, if
other drives on other machines are reallocating sectors as well).

Many reallocated sectors could be a sign that your drive is about to die...
Are you booting off this disk?

Have you run smartmontools on those bad disks?

You fail to mention your raid configuration.

Are you running the latest 3ware firmware for that controller?  There
is a Linux specific userspace firmware update utility.

Also, this topic is better served on the linux-scsi email list.

-Adam

On 8/8/06, Andy Davidson <andy@nosignal.org> wrote:
>
>
> Hi,
>
> One of our servers locked up (no kernel panic, but no response to
> console/network) with the following output on console :
>
> Aug  8 14:10:34 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x4383A7F.
> Aug  8 14:10:39 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4D9.
> Aug  8 14:10:41 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4DC.
> Aug  8 14:10:47 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB34.
> Aug  8 14:10:49 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB36.
> Aug  8 14:10:52 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x439051D.
> Aug  8 14:11:08 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
> (0x04:0x0023): Sector repair completed:port=1,LBA=0x4378D8A.
>
> I'd put this down to bad hardware until an identically spec'd machine
> (with fresh disks) did the same thing.
>
>
> Anyone else noticed any issues using the newer 3-ware 9550S cards with
> the 3w-9xxx driver ?
>
>
> Other details :
> Linux how-mail-1 2.6.16-2-686-smp #1 SMP Sat Jul 15 22:33:00 UTC 2006 i686
>
> from lspci:
> 03:03.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
>
>
> 3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
> ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 24 (level, low) -> IRQ 177
> scsi0 : 3ware 9000 Storage Controller
> 3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xda300000,
> IRQ: 177.
> 3w-9xxx: scsi0: Firmware FE9X 3.01.01.028, BIOS BE9X 3.01.00.024, Ports:
> 4. Vendor: AMCC      Model: 9550SX-4LP DISK
> Rev: 3.01 Type:   Direct-Access                      ANSI SCSI revision: 03f
>
>
> We'd welcome any help ?
>
> Thanks,
> Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
