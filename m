Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbRGKJwv>; Wed, 11 Jul 2001 05:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbRGKJwl>; Wed, 11 Jul 2001 05:52:41 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:59661 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S267264AbRGKJw1>;
	Wed, 11 Jul 2001 05:52:27 -0400
Date: Wed, 11 Jul 2001 11:52:26 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Switching Kernels without Rebooting?
To: cslater@wcnet.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B4C21DA.5FFCBE2@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C. Slater (cslater@wcnet.org) wrote :

> Hi, i was just thinking about if it would be possible to switch kernels 
> without haveing to restart the entire system. Sort of a "Live kernel 
> replacement". It sort of goes along with the hot-swap-everything ideas. I 
> was thinking something like 
> - Take all the structs related to userspace memory and processes 
> - Save them to a reserved area of memory 
> - Halt the kernel, mostly 
> - Wipe kernel-space memory clean to avoid confusion 
> - Load new kernel into memory 
> - Replace all saved structures 
> - Start kernel running agin 
> 
> This seems like the easiest way to do it. The biggest problem is that there 
> would be somewhere about 30 seconds where all processes would be frozen. 

This is not a problem at all, because UNIX does not guarantee that
a process will get at least one CPU slice every X seconds.
( read : UNIX is not a real time system )

soft-suspend "freezes" processes for several hours anyway ...

Note that there is a patch for hot replacing a kernel, which is equivalent
to rebooting, but much faster :
Two Kernel Monte (Linux loading Linux on x86)
http://www.scyld.com/products/beowulf/software/monte.html


> This could cause problems with tcp/ip connections timeing out say on a 
> webserver, but it would be more managable than a few minutes downtime to 
> restart the machine.

[ rest snipped ]

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
