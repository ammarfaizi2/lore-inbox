Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268037AbTAKTLM>; Sat, 11 Jan 2003 14:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTAKTLM>; Sat, 11 Jan 2003 14:11:12 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15571 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268037AbTAKTLL>; Sat, 11 Jan 2003 14:11:11 -0500
Date: Sat, 11 Jan 2003 20:19:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Tony <kernel@mail.vroon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (revised) fix net/irda warnings for 2.4.21-pre3
Message-ID: <20030111191952.GA21826@fs.tum.de>
References: <20030111120432.GA28023@sawmill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111120432.GA28023@sawmill>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 01:04:32PM +0100, Tony wrote:
> Patch download location:
> http://www.chainsaw.cistron.nl/compile-fixes-irda.patch.gz
> 
> The patch I announced several hours ago had issues. I have replaced the 
> file on the website with a correct version. If anyone had already 
> downloaded the fix, please do so again.
> This fixes the numerous "Concatenation of string literals with 
> __FUNCTION__ is depricated" errors in net/irda. This should apply 
> cleanly to both a 2.4.21-pre3 and a 2.4.21-pre3-ac3 tree.
>...

Did you try to compile all the files your patch changes?

The following things are obvious typos:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=ircomm_event  -c -o 
ircomm_event.o ircomm_event.c
ircomm_event.c: In function `ircomm_do_event':
ircomm_event.c:244: warning: too few arguments for format
ircomm_event.c: In function `ircomm_next_state':
ircomm_event.c:260: warning: unknown conversion type character `:' in format
ircomm_event.c:260: warning: int format, pointer arg (arg 3)
ircomm_event.c:260: warning: too many arguments for format
...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc 
-iwithprefix include -DKBUILD_BASENAME=irlan_common  -c -o 
irlan_common.o irlan_common.c
irlan_common.c: In function `irlan_open_data_tsap':
irlan_common.c:479: parse error before `return'
irlan_common.c: In function `irlan_set_multicast_filter':
irlan_common.c:814: warning: too many arguments for format
make[4]: *** [irlan_common.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/net/irda/irlan'

<--  snip  -->

> Thanks,
> Tony Vroon.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

