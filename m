Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTJaNAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJaNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:00:29 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:62655 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263292AbTJaNAV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:00:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Dan Bernard <djb29@cwru.edu>
Subject: Re: kernel: i8253 counting too high! resetting..
Date: Fri, 31 Oct 2003 08:00:19 -0500
User-Agent: KMail/1.5.1
Cc: CN <cnliou9@fastmail.fm>, linux-kernel@vger.kernel.org
References: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com> <200310310040.19519.gene.heskett@verizon.net> <20031031063636.GA61826@teraz.cwru.edu>
In-Reply-To: <20031031063636.GA61826@teraz.cwru.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310310800.19240.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.58.154] at Fri, 31 Oct 2003 07:00:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 01:36, Dan Bernard wrote:
>On 20031031 0040, Gene Heskett wrote:
>> >ALi
>> >M1542 A1
>> >100MHz
>> >Uniform Multi-Platform E-IDE driver Revision: 6.31
>> >ide: Assuming 33MHz system bus speed for PIO modes; override with
>> >idebus=xx
>>
>> This is correct, and for 2.4.20, I don't think the override works.
>>
>> > ...
>>
>> And again, while slower, this is the default bus speed FOR PIO,
>> Programmed I/O, not DMA.  Another animal entirely.  Running at
>> this 33MHZ speed, but without any handshaking, it can move 132Mb a
>> second because each access is 32 bits, or 4 bytes, wide.  Which is
>> still far faster than your drives can bring data past the heads. 
>> You are confusing the UDMA66 mode which exists on the drive cable,
>> with the bus speed the IDE card is plugged into, 2 entirely
>> different animals.
>>
>> > ...
>>
>> You'll need good cables, and a lengthy read of the hdparm manpage.
>> Then you can put the correct hdparm command to enable the UDMA66
>> mode right into your /etc/rc.d/rc.local script.
>
>ALi M1542 chipset is probably not too different from mine.  That's
> good, because if it were not ALi, then this would be much more
> complicated.
>
>The main problem here is not any kind of malfunction, but simply a
>component or group of components performing slightly below what is
>expected, and the software therefore generates unnecessary noise.
>
>I do not try to tweak any settings with hdparm unless something is
> broken. However, it looks like that may be your best bet in this
> particular case. I shall just continue putting up with the warnings
> for now.
>
>Still, if anyone gets these warnings without ALi chipsets, please do
> tell.
>
>Regards,
>Dan Bernard

Unforch, for this scene, both of my boards have VIA chipsets, so its 
not from personal experience, I'm just a CET with 55 years of chasing 
electrons for a living.  I've looked at the top of a lot of chips 
since IC's were invented.  If the boards are really fresh, maybe you 
could warranty the noisy one as being defective?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

