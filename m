Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317389AbSFRMMZ>; Tue, 18 Jun 2002 08:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSFRMMY>; Tue, 18 Jun 2002 08:12:24 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:25339 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317389AbSFRMMY>; Tue, 18 Jun 2002 08:12:24 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@transmeta.com>,
       <greg@kroah.com>, NAGANO Daisuke <breeze.nagano@nifty.ne.jp>
Subject: Re: [2.5 patch] drivers/usb/class/usb-midi.c must include linux/version.h
Date: Tue, 18 Jun 2002 22:08:17 +1000
User-Agent: KMail/1.4.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0206171706550.1866-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0206171706550.1866-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206182208.17139.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002 01:11, Adrian Bunk wrote:
> Line 109 is:
>   #if LINUX_VERSION_CODE  >= KERNEL_VERSION(2,4,14)
>
>
> The fix is simple:
>
> --- drivers/usb/class/usb-midi.c~	Mon Jun 17 04:31:24 2002
> +++ drivers/usb/class/usb-midi.c	Mon Jun 17 16:36:36 2002
> @@ -38,6 +38,7 @@
>  #include <linux/poll.h>
>  #include <linux/sound.h>
>  #include <linux/init.h>
> +#include <linux/version.h>
>  #include <asm/semaphore.h>
Why are we even doing this tes for a driver in the kernelt? Dump the test (and 
the include) for the in-kernel version.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
