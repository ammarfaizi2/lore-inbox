Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTKFOAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTKFN64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:58:56 -0500
Received: from pop.gmx.net ([213.165.64.20]:17555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263575AbTKFN6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:58:35 -0500
X-Authenticated: #4512188
Message-ID: <3FAA53F8.1060101@gmx.de>
Date: Thu, 06 Nov 2003 15:00:24 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de> <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de> <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de> <3FAA52A3.9030000@cyberone.com.au>
In-Reply-To: <3FAA52A3.9030000@cyberone.com.au>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
>> On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
>>
>>>>>> Heh indeed, maybe because the archs I use are still at 100. Looks
>>>>>> suspiciously like it's loosing timer interrupts, which would indeed
>>>>>> point to PIO.
>>>>>>
>>>>>>
>>>>> bash-2.05b# hdparm -I /dev/hdc
>>>>>
>>>>
>>>> -i please
>>>>
>>> bash-2.05b# hdparm -i /dev/hdc
>>>
>>> /dev/hdc:
>>>
>>> Model=LITE-ON LTR-16102B, FwRev=OS0K, SerialNo=
>>> Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>>> RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>>> BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>>> (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>>> IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
>>> PIO modes:  pio0 pio1 pio2 pio3 pio4
>>> DMA modes:  mdma0 mdma1 *mdma2
>>> AdvancedPM=no
>>>
>>> * signifies the current active mode
>>>
>>> The same: dma is active.
>>>
>>
>> Indeed, so you are ysing multiword mode 2. Can you try and do a dd from
>> the drive, while doing a vmstat 1? Also, does that show the jerky
>> behaviour?
>>
> 
> AFAIK, Prakash cannot reproduce this bad behaviour with mm1, only mm2 (is
> this right, Prakash?). So its something there (don't forget Andrew merges
> the latest bk with his releases too).


AFAIK, yes. Just too be 100% sure, I rather boot up mm1 and will do a 
test-run...

Prakash

