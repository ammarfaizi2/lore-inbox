Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSAaKPC>; Thu, 31 Jan 2002 05:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287381AbSAaKOw>; Thu, 31 Jan 2002 05:14:52 -0500
Received: from Expansa.sns.it ([192.167.206.189]:31244 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S285417AbSAaKOq>;
	Thu, 31 Jan 2002 05:14:46 -0500
Date: Thu, 31 Jan 2002 11:14:45 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: mochel@osdl.org, <linux-kernel@vger.kernel.org>
Subject: 2.5.3 does not compile on sparc64
Message-ID: <Pine.LNX.4.44.0201311108550.16240-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
I cannot compile kernel 2.5.3 on sparc64 platfom.
My HW are some Ultra II (both dual and mono processor systems),
with sparc64 II processor, and 1 GB RAM.

make[3]: Entering directory `/usr/src/linux-2.5.3/drivers/base'
sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.5.3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5
-fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -DEXPORT_SYMTAB
-c core.c
core.c:179: parse error before `device_init_root'
core.c:180: warning: return-type defaults to `int'
core.c:185: parse error before `device_driver_init'
core.c:186: warning: return-type defaults to `int'
make[3]: *** [core.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
make[1]: *** [_subdir_base] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.3/drivers'
make: *** [_dir_drivers] Error 2

Of course I had to correct dome
#include <malloc.h>
in
#include <slab.h> (this is the case).

Hope this helps

Luigi

