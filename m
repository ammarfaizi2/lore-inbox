Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbRFPS3S>; Sat, 16 Jun 2001 14:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbRFPS3I>; Sat, 16 Jun 2001 14:29:08 -0400
Received: from [212.18.228.90] ([212.18.228.90]:14864 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S264643AbRFPS2v>; Sat, 16 Jun 2001 14:28:51 -0400
Message-ID: <3B2BA529.8040107@linuxgrrls.org>
Date: Sat, 16 Jun 2001 19:27:53 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac14 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: Thomas Molina <tmolina@home.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <Pine.LNX.4.33.0106160827100.13727-100000@localhost.localdomain> <002201c0f66e$90675360$3303a8c0@einstein>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christian Bornträger wrote:

>>If possible, can you remove the hard disc from the promise and attach it on
>>the VIA-Controller and test if the problem still occurs? (prepare a bootdisc
>>if you cannot boot. Propably, you have to pass a new root-partition to the
>>kernel)
>>I hardly believe that the promise controller has some problems with the new
>>VIA setup introduced in 2.4.3-ac7. Using the promise ports of the A7V133 is
>>the only correlation I see again and again...
>>
Yes, plugging the drive into the primary VIA IDE port, it seems to work 
perfectly. Am now on 2.4.5-ac14 with UDMA5 enabled and it seems quite happy.

Which would seem to indicate that yes, it *is* a Promise issue - or at 
least a Promise-on-VIA issue.

FWIW the Promise BIOS announces itself as version 2.01 build 35.

erk...

Thus far I've been presuming that the Promise IDE ports were 
UDMA100/66/33 and the VIA IDE ports were UDMA66/33, and thus naturally 
wanted to use the Promise ports to get better performance. Now, on more 
careful reading of the manual, it seems to be telling me that *all* of 
the IDE ports are UDMA100/66/33, the main benefit of the Promise chip 
besides being able to plug more IDE devices in, being the RAID 0 support 
(which I don't need [yet]). Then, on looking again at the bonnie 
*results* (rather than just noting that it hadn't *crashed*), I notice 
that the figures are about the same, possibly marginally better, than 
those I was getting out of the Promise ports.

And there I thought I'd have to be slumming it... Doh! :-} <sheepish/>

-- 
Rachel


