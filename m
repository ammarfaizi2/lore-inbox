Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281913AbRKUPmS>; Wed, 21 Nov 2001 10:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281912AbRKUPmJ>; Wed, 21 Nov 2001 10:42:09 -0500
Received: from sdsl-64-32-181-131.dsl.lax.megapath.net ([64.32.181.131]:63624
	"EHLO brigadier.ontimesupport.com") by vger.kernel.org with ESMTP
	id <S281909AbRKUPlv>; Wed, 21 Nov 2001 10:41:51 -0500
Message-Id: <5.1.0.14.0.20011121093412.00a92e78@127.0.0.1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Nov 2001 09:41:47 -0600
To: <linux-kernel@vger.kernel.org>
From: Matthew Sell <msell@ontimesupport.com>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <Pine.LNX.4.33.0111211316220.4080-100000@Appserv.suse.de>
In-Reply-To: <20011121130838.D9978@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The results of "dmesg" on my dual-Athlon show a (rather comical) 
discrepancy, it's not a big deal - just funny (to me)....

I was just wondering if this was a similar behavior to the earlier posts on 
this topic:


Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2


Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU0: AMD Athlon(tm) Processor stepping 04
per-CPU timeslice cutoff: 731.77 usecs.


Intel machine check reporting enabled on CPU#1.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU1: AMD Athlon(tm) Processor stepping 04
Total of 2 processors activated (5564.00 BogoMIPS).


         - Matt



At 01:19 PM 11/21/2001 +0100, Dave Jones wrote:
>On Wed, 21 Nov 2001, Jens Axboe wrote:
>
> > Strange, I was pretty sure that earlier 2.4.x got it right. Oh well.
>
>*shrug* As we don't do any setting of this string, all I can guess
>at is that the new seqfile based /proc/cpuinfo code is stricter
>about getting the info from the right CPU than the older code was.
>
>Though I'm not sure why, as the older code just read from the
>per-CPU structs anyway.  Most odd.
>
>regards,
>Dave.
>
>--
>| Dave Jones.        http://www.codemonkey.org.uk
>| SuSE Labs
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/



Matthew Sell
Programmer
On Time Support, Inc.
www.ontimesupport.com
(281) 296-6066

Join the Metrology Software discussion group METLIST!
http://www.ontimesupport.com/cgi-bin/mojo/mojo.cgi


"One World, One Web, One Program" - Microsoft Promotional Ad
"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler

Many thanks for this tagline to a fellow RGVAC'er...

