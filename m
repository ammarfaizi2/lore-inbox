Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUGMMbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUGMMbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGMMbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:31:40 -0400
Received: from adsl-65-68-136-66.dsl.stlsmo.swbell.net ([65.68.136.66]:45012
	"EHLO demigod.technicalworks.net") by vger.kernel.org with ESMTP
	id S264922AbUGMMba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:31:30 -0400
Message-ID: <015701c468d5$818dc090$0200000a@darkomen.lan>
From: "Dwayne Rightler" <drightler@technicalogic.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Dhruv Matani" <dhruvbird@gmx.net>
References: <1089721822.4215.3.camel@localhost.localdomain>
Subject: Re: DriveReady SeekComplete Error...
Date: Tue, 13 Jul 2004 07:32:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Spam-DCC: :
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem with a Samsung hard drive. Model SV2044D.  The
output of 'hdparm -i' below indicates it supports several multiword and
ultra DMA modes but if i run the drive in anything other than PIO mode it
gets DMA timeouts and SeekComplete Errors.  This has been on every kernel I
can recall in the 2.4 and 2.6 series.

demigod:~# hdparm -i /dev/hda

/dev/hda:

 Model=SAMSUNG SV2044D, FwRev=MM200-53, SerialNo=0228J1FN905733
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39862368
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4

 * signifies the current active mode



----- Original Message ----- 
From: "Dhruv Matani" <dhruvbird@gmx.net>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 13, 2004 7:30 AM
Subject: DriveReady SeekComplete Error...


> Hi,
> I've been getting this error for my brand new (2 months old) Samsung
> HDD. The model Number is: SV0411N, and it is a 40GB disk. I'm using the
> kernel version 2.4.20-8 provided by RedHat. When I used RH-7.2(before
> upgrading to RH-9), the same HDD worked fine. Also, when I re-installed
> RH-7.2, it worked fine?
>
> Any suggestions?
>
> Please cc me the reply, sine I'm not subscribed.
> Thanks ;-)
>
> -- 
>         -Dhruv Matani.
> http://www.geocities.com/dhruvbird/
>
> As a rule, man is a fool. When it's hot, he wants it cold.
> When it's cold he wants it hot. He always wants what is not.
> -Anon.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

