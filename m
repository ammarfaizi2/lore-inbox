Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbRDZQYV>; Thu, 26 Apr 2001 12:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135275AbRDZQYL>; Thu, 26 Apr 2001 12:24:11 -0400
Received: from c4.h061013036.is.net.tw ([61.13.36.4]:6668 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S135263AbRDZQXy>; Thu, 26 Apr 2001 12:23:54 -0400
Message-ID: <611C3E2A972ED41196EF0050DA92E0760265D56C@EXCHANGE2>
From: Yiping Chen <YipingChen@via.com.tw>
To: "'kernel@kvack.org'" <kernel@kvack.org>,
        Yiping Chen <YipingChen@via.com.tw>
Cc: "'Vivek Dasmohapatra'" <vivek@etla.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
Date: Fri, 27 Apr 2001 00:24:01 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
I am interested in where can find the linux kernel spec. file, and where Red
Hat add the smp string?
Where the uname command extract the kernel version information(eg:
2.4.2-2smp or 2.2.16)?
I means from which file, or use which system call?

I am a linux driver writer, and I am writing Makefile now. I hope the
Makefile can install driver 
to the correct directory automatically (user run 'make install').
The linux driver modules always put  in /lib/modules/<kernel_version>/...
before (in kernel 2.2.16),
but in kernel 2.4.x, the path change to
/lib/modules/<kernel_version>/kernel/drivers/...
I don't know where to get the kernel_version information. I need some help.
Thanks!!
may I use uname? I worry that the driver will install to incorrect path, and
user will complain it.
thanks!!


-----Original Message-----
From: kernel@kvack.org [mailto:kernel@kvack.org]
Sent: Friday, April 27, 2001 12:03 AM
To: Yiping Chen
Cc: 'Vivek Dasmohapatra'; 'linux-kernel@vger.kernel.org'
Subject: RE: About rebuild 2.4.x kernel to support SMP.


On Thu, 26 Apr 2001, Yiping Chen wrote:

> So, I have two question now, 
> 1. how to determine whether your kernel support SMP?
>     Somebody taugh me that you can type  "uname -r", but it seems not
> correct.

No, it's correct: the Red Hat RPM is build from the kernel.spec file which
adds the smp string to the version.

> 2. I remember in 2.2.x, when I rebuild the kernel which support SMP, the
> compile
>     argument will include -D__SMP__ , but this time, when I rebuild kernel
> 2.4.2-2 , it didn't  appear.
>     Why? 

Because you've made an assumption that holds no value.  2.4 kernels rely
on CONFIG_SMP instead of __SMP__.

		-ben
