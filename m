Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTELA3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTELA3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:29:03 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:50135 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S261562AbTELA3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:29:01 -0400
Date: Mon, 12 May 2003 12:41:28 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Valdis.Kletnieks@vt.edu
cc: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100 
Message-ID: <854719.1052743288@[192.168.1.249]>
In-Reply-To: <200305112048.h4BKmdkc006140@turing-police.cc.vt.edu>
References: <1405.1052575075@www9.gmx.net>           
 <3191078.1052695705@[192.168.1.249]>
 <200305112048.h4BKmdkc006140@turing-police.cc.vt.edu>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, 11 May 2003 4:48 p.m. -0400 Valdis.Kletnieks@vt.edu wrote:

> On Sun, 11 May 2003 23:28:25 +1200, Andrew McGregor
> <andrew@indranet.co.nz>  said:
>
>> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the
>> *internal power supplies* of the i8x00 series make wierd noises when APM
>> tries to idle the CPU.  The board will do this anyway, without making
>> noise, so linux need not.
>
> Dell Latitude C840 (1.6G Pentium4 Mobile) has the "power supplies buzz at
> 1Khz on APM idle" symptom too. I haven't checked the ACPI side of the
> fence yet, nor have I gotten brave enough to try the cpufreq and
> speedstep stuff.

AFAIK Speedstep should always work on P4M systems, so it's worth a try.

>
> Even *more* bizarre, there's "something odd" done by the seti@home client
> (which usually causes 100% CPU use and thus silence) several minutes into
> a workunit that causes  the noise to change frequencies - it will start
> down around 500hz, sweep up to 1Khz (taking about 2 seconds to do so),
> and repeat (so the buzzing is exhibiting a sawtooth wave).  I'm not
> seeing any paging or swapping or I/O, so I'm wondering if it's some code
> walking through a large array with strides 1/2/4/8/16 (like an FFT)
> causing different cache hit ratios, and thus different power consumption
> patterns while it's stuck on a L1/L2 cache miss.....
>

That's pretty bizzarre, I agree :-)

Probably it's an autocorrelation with a sliding offset.  I'd guess that the 
reason the buzz starts at 500Hz and sweeps up is that if the frequency is 
below 500Hz you don't hear it.  Maybe the RAM starts sucking more power as 
the cache hit ratio drops...

Andrew
