Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312328AbSCYHNx>; Mon, 25 Mar 2002 02:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSCYHNo>; Mon, 25 Mar 2002 02:13:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27913 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312183AbSCYHN0>;
	Mon, 25 Mar 2002 02:13:26 -0500
Date: Mon, 25 Mar 2002 08:13:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon <marsaro@interearth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Error with Compaq CCISS
Message-ID: <20020325071316.GB13328@suse.de>
In-Reply-To: <00fd01c1d2b7$9d020d10$1900a8c0@minniemouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23 2002, Jon wrote:
> Anyone else seen this? I am using 2.5.7 no prepatch
> 
> .c
> cciss.c: In function `cciss_ioctl':
> cciss.c:645: warning: implicit declaration of function `DECLARE_COMPLETION'
> cciss.c:645: `wait' undeclared (first use in this function)
> cciss.c:645: (Each undeclared identifier is reported only once
> cciss.c:645: for each function it appears in.)
> cciss.c:720: warning: implicit declaration of function `wait_for_completion'
> cciss.c: In function `sendcmd_withirq':
> cciss.c:932: `wait' undeclared (first use in this function)
> cciss.c: In function `do_cciss_intr':
> cciss.c:1958: warning: implicit declaration of function `complete'
> make[3]: *** [cciss.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.7/drivers/block'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.7/drivers/block'
> make[1]: *** [_subdir_block] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.7/drivers'
> make: *** [_dir_drivers] Error 2
> cumin:/usr/src/linux-2.5.7 #

--- drivers/block/cciss.c~	Mon Mar 25 08:12:41 2002
+++ drivers/block/cciss.c	Mon Mar 25 08:12:33 2002
@@ -36,6 +36,7 @@
 #include <linux/init.h> 
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
+#include <linux/completion.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>

-- 
Jens Axboe

