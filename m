Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275576AbRJFTmP>; Sat, 6 Oct 2001 15:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275611AbRJFTmG>; Sat, 6 Oct 2001 15:42:06 -0400
Received: from getafix.lostland.net ([216.29.29.44]:54585 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S275576AbRJFTlw>; Sat, 6 Oct 2001 15:41:52 -0400
Date: Sat, 6 Oct 2001 15:42:21 -0400 (EDT)
From: adrian <adrian@lostland.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Tekram 390U2W and 2.4.10
In-Reply-To: <Pine.BSO.4.33.0110051048380.24274-100000@getafix.lostland.net>
Message-ID: <Pine.BSO.4.33.0110061536500.8534-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, to follow up my own post, I've checked the archives and found people
having problems (not quite the same as mine) with Tekram 390U2Ws, but not
recently (but I didn't spot any fixes...).  I went through the 2.4.10-prex
series and found that the last one that works for me is pre10.  I looked
at the changes after pre10, and couldn't find anything I thought was the
culprit, but then again...

Strangeness...

Regards,
Adrian


On Fri, 5 Oct 2001, adrian wrote:

>
> Hello,
>
>    I have a Tekram SCSI card I've been using for a while, and it's always
> had problems in Windows with the newest drivers from Tekram, but works
> fine with the generic NCR drivers in Windows.  I've never had any problems
> with it in Linux until 2.4.10.  If I try something like:
>
> # dd if=/dev/scd1 of=image.iso
>
> I get:
>
> scsi0 channel 0 : resetting for second half of retries.
> SCSI bus is being reset for host 0 channel 0.
> ncr53c8xx_reset: pid=0 reset_flags=1 serial_number=0
> serial_number_at_timeout=0
> scsi0: device driver called scsi_done() for a synchronous reset.
> scsi0 channel 0 : resetting for second half of retries.
> SCSI bus is being reset for host 0 channel 0.
> ncr53c8xx_reset: pid=0 reset_flags=1 serial_number=0
> serial_number_at_timeout=0
> scsi0: device driver called scsi_done() for a synchronous reset.
> SCSI cdrom error : host 0 channel 0 id 4 lun 0 return code = 27070000
>  I/O error: dev 0b:01, sector 400
> scsi0 channel 0 : resetting for second half of retries.
> SCSI bus is being reset for host 0 channel 0.
> ncr53c8xx_reset: pid=0 reset_flags=1 serial_number=0
> serial_number_at_timeout=0
> scsi0: device driver called scsi_done() for a synchronous reset.
> SCSI cdrom error : host 0 channel 0 id 4 lun 0 return code = 27070000
>  I/O error: dev 0b:01, sector 402
> ncr53c895-0-<4,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 7)
>  I/O error: dev 0b:01, sector 654
>  I/O error: dev 0b:01, sector 400
>
> I've tried both NCR and SYMBIOS drivers, but same story.  However, I can
> successfully mount partitions and CDROM's and copy data without errors.
> And, in 2.4.9, dd'ing works without problems.  In Windows, the problem I
> had was that the SCSI bus would constantly reset itself every 5 or
> so seconds whenever a device was being access.  I don't know if these
> problems are related, but I thought I'd mention it.  I have tried moving
> the card to another system with a different motherboard, to satisfy
> curiosity.  The problem still exists.  I didn't notice any changes in the
> symbios or ncr drivers.  Any ideas?  Thanks.
>
> Regards,
> Adrian
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

