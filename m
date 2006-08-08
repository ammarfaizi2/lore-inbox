Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWHHSiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWHHSiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWHHSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:38:52 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:8937 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S965022AbWHHSis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:38:48 -0400
Message-ID: <44D8E1B1.9050106@wolfmountaingroup.com>
Date: Tue, 08 Aug 2006 13:10:41 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adam radford <aradford@gmail.com>
CC: Andy Davidson <andy@nosignal.org>, linux-kernel@vger.kernel.org
Subject: Re: 3ware 9550 using 3w-9xxx driver lockups ?
References: <44D89D5D.1000808@nosignal.org> <b1bc6a000608081132p2178caa3sd0c9e12813e28ef2@mail.gmail.com>
In-Reply-To: <b1bc6a000608081132p2178caa3sd0c9e12813e28ef2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam radford wrote:

> Looks to me like you have a bad drive (or several bad drives, if
> other drives on other machines are reallocating sectors as well).
>
> Many reallocated sectors could be a sign that your drive is about to 
> die...
> Are you booting off this disk?
>
> Have you run smartmontools on those bad disks?
>
> You fail to mention your raid configuration.
>
> Are you running the latest 3ware firmware for that controller?  There
> is a Linux specific userspace firmware update utility.
>
> Also, this topic is better served on the linux-scsi email list.
>
> -Adam
>
> On 8/8/06, Andy Davidson <andy@nosignal.org> wrote:
>
>>
>>
>> Hi,
>>
>> One of our servers locked up (no kernel panic, but no response to
>> console/network) with the following output on console :
>>
>> Aug  8 14:10:34 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x4383A7F.
>> Aug  8 14:10:39 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4D9.
>> Aug  8 14:10:41 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438C4DC.
>> Aug  8 14:10:47 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB34.
>> Aug  8 14:10:49 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x438FB36.
>> Aug  8 14:10:52 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x439051D.
>> Aug  8 14:11:08 how-mail-1 kernel: 3w-9xxx: scsi0: AEN: WARNING
>> (0x04:0x0023): Sector repair completed:port=1,LBA=0x4378D8A.
>>
>> I'd put this down to bad hardware until an identically spec'd machine
>> (with fresh disks) did the same thing.
>>
>>
>> Anyone else noticed any issues using the newer 3-ware 9550S cards with
>> the 3w-9xxx driver ?
>>
>>
>> Other details :
>> Linux how-mail-1 2.6.16-2-686-smp #1 SMP Sat Jul 15 22:33:00 UTC 2006 
>> i686
>>
>> from lspci:
>> 03:03.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
>>
>>
>> 3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
>> ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 24 (level, low) -> IRQ 177
>> scsi0 : 3ware 9000 Storage Controller
>> 3w-9xxx: scsi0: Found a 3ware 9000 Storage Controller at 0xda300000,
>> IRQ: 177.
>> 3w-9xxx: scsi0: Firmware FE9X 3.01.01.028, BIOS BE9X 3.01.00.024, Ports:
>> 4. Vendor: AMCC      Model: 9550SX-4LP DISK
>> Rev: 3.01 Type:   Direct-Access                      ANSI SCSI 
>> revision: 03f
>>
>>
>> We'd welcome any help ?
>>
>> Thanks,
>> Andy
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Adam,

Have him check the cables as well unless he using the multi-lane 
controller.  I see this a lot with loose ATA cables
on units, but since we moved over to the multi-lane architecture -- 
great work on the multi-lane version of the adapters, BTW.
He should also check is he's getting -2 bio errors.  I see -2 bio errors 
in parallel with this if its a bad cable.

Jeff
