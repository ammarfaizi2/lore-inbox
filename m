Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVLORfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVLORfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLORfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:35:48 -0500
Received: from smtp-out.google.com ([216.239.33.17]:54446 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750825AbVLORfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:35:48 -0500
Message-ID: <43A1A95D.10800@mbligh.org>
Date: Thu, 15 Dec 2005 09:35:25 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New build failure since -mm2:
Config is 
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67

I'm guessing it was using gcc 2.95.4, though not sure.

   CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/stddef.h:4,
                  from include/linux/posix_types.h:4,
                  from include/linux/types.h:13,
                  from include/linux/capability.h:16,
                  from include/linux/sched.h:7,
                  from arch/i386/kernel/asm-offsets.c:7:
include/linux/compiler.h:46: #error Sorry, your compiler is too old/not 
recognized.
In file included from include/linux/bitops.h:77,
                  from include/linux/thread_info.h:20,
                  from include/linux/preempt.h:10,
                  from include/linux/spinlock.h:50,
                  from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/i386/kernel/asm-offsets.c:7:
include/asm/bitops.h: In function `sched_find_first_bit':
include/asm/bitops.h:380: warning: implicit declaration of function 
`__builtin_expect'
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
12/15/05-06:51:19 Build the kernel. Failed rc = 2
12/15/05-06:51:19 build: kernel build Failed rc = 1
12/15/05-06:51:19 command complete: (2) rc=126
Failed and terminated the run
  Fatal error, aborting autorun
