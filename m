Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSE2W7I>; Wed, 29 May 2002 18:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSE2W7H>; Wed, 29 May 2002 18:59:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22282 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315708AbSE2W7F>; Wed, 29 May 2002 18:59:05 -0400
Message-ID: <3CF54F8E.9030009@evision-ventures.com>
Date: Thu, 30 May 2002 00:00:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
CC: "Udo A. Steinberg" <reality@delusion.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE breakage with cdrom in 2.5.18+
In-Reply-To: <3CF53160.B97CE3E2@delusion.de> <m2it56jsuo.fsf@vador.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Vignaud wrote:
> "Udo A. Steinberg" <reality@delusion.de> writes:
> 
> 
>>/dev/hde shows packet command errors upon bootup. Any ideas?
> 
> 
>>hda: IBM-DTLA-307030, ATA DISK drive
>>hdb: IBM-DTLA-307030, ATA DISK drive
>>hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
>>ide0 at 0x9400-0x9407,0x9002 on irq 10
>>ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
>> hda: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
>> hda: hda1
>> hdb: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
>> hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
>>hde: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
>>Uniform CD-ROM driver Revision: 3.12
>>hde: packet command error: status=0x51 { DriveReady SeekComplete Error } 
>>hde: packet command error: error=0x54
>>ATAPI device hde:
>>  Error: Illegal request -- (Sense key=0x05)
>>  Invalid field in command packet -- (asc=0x24, ascq=0x00)
>>  The failed "Request Sense" packet command was: 
>>  "03 00 00 00 12 00 00 00 00 00 00 00 "
> 
> 
> afaic looks "try to detect partitions" lookup that should not had been
> done on cdrom :-(
> 

Just remove (or tweak) the ata_revalidate from the recently added attach method
there and you should be fine perhaps. I will check this
tomorrow later. This doesn't happen with a modularized driver and
therefore the chances are indeed very high that this is the
culprit.

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

