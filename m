Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291203AbSBGSYs>; Thu, 7 Feb 2002 13:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBGSYi>; Thu, 7 Feb 2002 13:24:38 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:65339
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S291192AbSBGSY0>; Thu, 7 Feb 2002 13:24:26 -0500
Message-ID: <3C62C652.9070903@switchmanagement.com>
Date: Thu, 07 Feb 2002 10:24:18 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Michael Cohen <lkml@ohdarn.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.4.18-pre8-mjc: compile errors
In-Reply-To: <1013073474.3684.3.camel@ohdarn.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got some miscellaneous errors/warnings upon compiling (this is with an 
SMP build, .config is available if needed).  I don't need these modules 
(I was just doing my standard "compile as much as possible" routine), so 
I just disabled them and continued on my way.

gcc -D__KERNEL__ -I/home/bstrand/src/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 
-fomit-frame-pointeri2c-tsunami.c:35: asm/hwrpb.h: No such file or directory
i2c-tsunami.c:36: asm/core_tsunami.h: No such file or directory
gcc -D__KERNEL__ -I/home/bstrand/src/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointergcc 
-D__KERNEL__ -I/home/bstrand/src/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 
-fomit-frame-pointeri2c-tsunami.c: In function `writempd':
i2c-tsunami.c:72: `TSUNAMI_cchip' undeclared (first use in this function)
i2c-tsunami.c:72: (Each undeclared identifier is reported only once
i2c-tsunami.c:72: for each function it appears in.)
i2c-tsunami.c: In function `readmpd':
i2c-tsunami.c:78: `TSUNAMI_cchip' undeclared (first use in this function)
i2c-tsunami.c:79: warning: control reaches end of non-void function
i2c-tsunami.c: In function `i2c_tsunami_init':
i2c-tsunami.c:156: `hwrpb' undeclared (first use in this function)
i2c-tsunami.c:156: `ST_DEC_TSUNAMI' undeclared (first use in this function)
i2c-tsunami.c:160: `TSUNAMI_cchip' undeclared (first use in this function)

gcc -D__KERNEL__ -I/home/bstrand/src/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointerr128_cce.c: 
In function `r128_cce_packet':
r128_cce.c:1023: warning: unused variable `size'
r128_cce.c:1021: warning: unused variable `buffer'
r128_cce.c:1019: warning: unused variable `dev_priv'

gcc -D__KERNEL__ -I/home/bstrand/src/linux-2.4.17/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointeri810_dma.c: 
In function `i810_free_page':
i810_dma.c:296: warning: passing arg 1 of `wake_up_page_Rsmp_4acd422b' 
makes pointer from integer without a cast

Regards,
Brian


