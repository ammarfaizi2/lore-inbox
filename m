Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTLOLIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTLOLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:08:42 -0500
Received: from cpe.atm0-0-0-196102.0x3ef2770b.arcnxx4.customer.tele.dk ([62.242.119.11]:7399
	"EHLO liabserver.liab.dk") by vger.kernel.org with ESMTP
	id S263528AbTLOLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:08:36 -0500
Message-ID: <3FDD9630.20205@starbattle.com>
Date: Mon, 15 Dec 2003 12:08:32 +0100
From: Daniel Lux <daniel@starbattle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: steve@drifthost.com
CC: linux-kernel@vger.kernel.org
Subject: Re: no DRQ after issuing WRITE
References: <OJ0u.30g.5@gated-at.bofh.it> <OJMR.41A.9@gated-at.bofh.it> <OKSD.5oD.5@gated-at.bofh.it>
In-Reply-To: <OKSD.5oD.5@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had the same problem on a slow system with high load, I made a patch 
against this problem. Which kernel version are you using and would you 
be willing to try my patch?

Regards
Daniel Lux

Systems Developer
LIAB Electronics Aps				Tel: +45 97370644
Støvring Vækstcenter, Østre Allé 6 		Email: lux@liab.dk
DK-9530 Støvring,  Denmark	

steve@drifthost.com wrote:
> Well i only just started getting them and i started with 2.4.20 and
> upgraded to 2.4.21 about 6weeks or so ago (or when it came out)
> 
> Started gettig errors about 4-5days ago..
> 
> Ive seen alot of other ppl with the same error on early kernels..
> 
> Any idea what it is
> 
> 
>>I do not have time to pause and trace/fix the mess.
>>However if you both can kindly finger the last kernel when you did not
>>have this error, it will help constrain the pain.
>>
>>Cheers,
>>
>>Andre Hedrick
>>LAD Storage Consulting Group
>>
>>On Wed, 5 Nov 2003, Robert L. Harris wrote:
>>
>>
>>>
>>>No answer for you but I've gotten this message also and was hoping
>>>someone would know what/why...
>>>
>>>
>>>Thus spake Steven Adams (steve@drifthost.com):
>>>
>>>
>>>>anyone?
>>>>----- Original Message -----
>>>>From: <steve@drifthost.com>
>>>>To: <linux-kernel@vger.kernel.org>
>>>>Sent: Wednesday, November 05, 2003 2:05 PM
>>>>Subject: hda: no DRQ after issuing WRITE
>>>>
>>>>
>>>>
>>>>>Hey guys,
>>>>>
>>>>>i keep getting things like this in my dmesg
>>>>>
>>>>>============================================
>>>>>hda: status timeout: status=0xd0 { Busy }
>>>>>
>>>>>hda: no DRQ after issuing WRITE
>>>>>ide0: reset: success
>>>>>hda: status timeout: status=0xd0 { Busy }
>>>>>
>>>>>hda: no DRQ after issuing WRITE
>>>>>ide0: reset: success
>>>>>=============================================
>>>>>
>>>>>From hdparm
>>>>>============================================
>>>>>/dev/hda:
>>>>>
>>>>> Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
>>>
>>>Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>>>
>>>>> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>>>>> BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16,
>>>
>>>MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
>>>LBAsects=160836480 IORDY=on/off, tPIO={min:240,w/IORDY:120},
>>>tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
>>>
>>>>> DMA modes:  mdma0 mdma1 mdma2
>>>>> UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>>>>> AdvancedPM=yes: disabled (255) WriteCache=enabled
>>>>> Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
>>>>>=================================================
>>>>>
>>>>>Ive searched high and low to try find out what this means, all ive
>>>
>>>found it people keep saying its all different kinds of things..
>>>
>>>>>I was wondering if this means my hdd is drying or is ti a setting?
>>>>>
>>>>>Thanks guys,
>>>>>Steve
>>>>>
>>>>>
>>>>>-
>>>>>To unsubscribe from this list: send the line "unsubscribe
>>>
>>>linux-kernel" in the body of a message to
>>>majordomo@vger.kernel.org
>>>
>>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe
>>>
>>>linux-kernel" in the body of a message to majordomo@vger.kernel.org
>>>
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>:wq!
>>>---------------------------------------------------------------------------
>>>Robert L. Harris                     | GPG Key ID: E344DA3B
>>>                                         @ x-hkp://pgp.mit.edu
>>>DISCLAIMER:
>>>      These are MY OPINIONS ALONE.  I speak for no-one else.
>>>
>>>Life is not a destination, it's a journey.
>>>  Microsoft produces 15 car pileups on the highway.
>>>    Don't stop traffic to stand and gawk at the tragedy.
>>>
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

