Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbSKUGXB>; Thu, 21 Nov 2002 01:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbSKUGXB>; Thu, 21 Nov 2002 01:23:01 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40198
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266356AbSKUGXA>; Thu, 21 Nov 2002 01:23:00 -0500
Date: Wed, 20 Nov 2002 22:29:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Osamu Tomita <tomita@cinet.co.jp>
cc: "'LKML '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.47-ac6 IDE test result
In-Reply-To: <E6D19EE98F00AB4DB465A44FCF3FA46903A318@ns.cinet.co.jp>
Message-ID: <Pine.LNX.4.10.10211202218280.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Osamu,

I know the fix need for taskfile but have not architech the solution in
closed form yet.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 21 Nov 2002, Osamu Tomita wrote:

> Hi.
> I've tested IDE HDD performance on 2.5.47-ac6.
> Using old pentium-classic PC-9800 box, it has no DMA mode.
> 
>  1. "hdparm -t /dev/hda3" results (PIO mode)
>   2.5.47-ac6 with Task file IO:    2.86MB/s
>   2.5.47-ac6 without Task file IO: 2.90MB/s
>   2.4.19 without Task file IO:     2.93MB/s
> 
>  2. Heavy usage test
>   "cp -pr /usr/src /tmp/foo" (in same HDD)
>   about 92000files/total size 2.3GB
>   I had always "lost interrupt" message and FS corruption
>    by this test at 2.5.20 days.
>   2.5.47-ac6 works fine. (takes about 30 minutes.)
> 
> Thanks,
> Osamu Tomita
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

