Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbQKCVMY>; Fri, 3 Nov 2000 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131544AbQKCVMO>; Fri, 3 Nov 2000 16:12:14 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:55695 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S131405AbQKCVMF>; Fri, 3 Nov 2000 16:12:05 -0500
From: davej@suse.de
Date: Fri, 3 Nov 2000 21:11:59 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: celeron-class misdetected as 486
Message-ID: <Pine.LNX.4.21.0011032105470.3365-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote..

> pavel@bug:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 4
                    ^^^
Since when were there family 4 Celerons ?

> model           : 0
> model name      : 486 DX-25/33
> stepping        : 0
> cache size      : 128 KB

Though a 486 with 128K cache is also unlikely.
(Although some of the wierd overdrives had such added fun iirc)

>.... that's wrong. Older kernels detect it correctly as:
>May 10 21:39:04 bug kernel: Pentium-III serial number disabled.
>May 10 21:39:04 bug kernel: CPU: Intel Celeron (Mendocino) stepping 0a

Which older kernel detected this ?

This is really bizarre, as there are cpuid capable 486s with the
family/vendor IDs reported above. I do hope we don't have to add
more cachesize checking. That part of setup.c is ugly enough
already.

Can you open up and find out if it really is a Celeron in that box
before such code gets added ?

regards,

Dave.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
