Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292147AbSBAXyf>; Fri, 1 Feb 2002 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292148AbSBAXy0>; Fri, 1 Feb 2002 18:54:26 -0500
Received: from waste.org ([209.173.204.2]:62866 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S292147AbSBAXyT>;
	Fri, 1 Feb 2002 18:54:19 -0500
Date: Fri, 1 Feb 2002 17:54:18 -0600 (CST)
From: Brak <brak@waste.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.5.3 DAC960 won't compile
Message-ID: <Pine.LNX.4.44.0202011752200.7986-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling the 2.5.3 kernel it errors out on the DAC960

The build host is 2.4 based

Below is the output from make during the compile:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.3/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c
DAC960.c
In file included from DAC960.c:49:
DAC960.h: In function `DAC960_AcquireControllerLock':
DAC960.h:2511: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.h: In function `DAC960_ReleaseControllerLock':
DAC960.h:2523: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.h: In function `DAC960_AcquireControllerLockIH':
DAC960.h:2560: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.h: In function `DAC960_ReleaseControllerLockIH':
DAC960.h:2573: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c: In function `DAC960_WaitForCommand':
DAC960.c:309: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c:311: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
DAC960.c: In function `DAC960_RegisterBlockDevice':
DAC960.c:1948: too few arguments to function `blk_init_queue'
DAC960.c:1961: structure has no member named `MaxSectorsPerRequest'
DAC960.c: In function `DAC960_RegisterDisk':
DAC960.c:2076: incompatible type for argument 2 of `register_disk'
DAC960.c:2088: incompatible type for argument 2 of `register_disk'
DAC960.c: In function `DAC960_V1_QueueReadWriteCommand':
DAC960.c:2745: warning: implicit declaration of function `bio_size'
DAC960.c: In function `DAC960_ProcessCompletedBuffer':
DAC960.c:2948: too few arguments to function
DAC960.c: In function `DAC960_Open':
DAC960.c:5302: invalid operands to binary &
DAC960.c: In function `DAC960_UserIOCTL':
DAC960.c:5539: warning: passing arg 1 of `spin_unlock' from incompatible
pointer type
DAC960.c:5543: warning: passing arg 1 of `spin_lock' from incompatible
pointer type
make[3]: *** [DAC960.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.3/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.3/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.3/drivers'
make: *** [_dir_drivers] Error 2


-- 
-brak

