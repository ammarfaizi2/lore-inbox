Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRG0O10>; Fri, 27 Jul 2001 10:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268863AbRG0O1Q>; Fri, 27 Jul 2001 10:27:16 -0400
Received: from jaws.cisco.com ([198.135.0.150]:44439 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S268861AbRG0O1L>;
	Fri, 27 Jul 2001 10:27:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick Brown <nicbrown@cisco.com>
Reply-To: nicbrown@cisco.com
Organization: Cisco Systems Ltd.
To: linux-kernel@vger.kernel.org
Subject: problem configuring for a mips platform
Date: Fri, 27 Jul 2001 15:23:53 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072715235305.12313@edin-ios-26.cisco.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

While trying to configure the 2.4.7 kernel for cross compilation to a new 
mips platform I get the following errors;

> ls
COPYING         MAINTAINERS  REPORTING-BUGS  drivers/  init/    lib/  scripts/
CREDITS         Makefile     Rules.make      fs/       ipc/     mm/
Documentation/  README       arch/           include/  kernel/  net/
> make ARCH=mips xconfig
rm -f include/asm
( cd include ; ln -sf asm-mips asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/home/nicbrown/cross/linux/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.cgcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o 
tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/mips/config.in >> kconfig.tk
-: 364: unable to open drivers/message/i2o/Config.in
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/home/nicbrown/cross/linux/scripts'
make: *** [xconfig] Error 2
>

Is this a bug, or am I missing something. This is in a freshly un tarred 
source directory. Do I need to edit anything or add more to the make command?

Cheers,
Nick

-- 
If you don't let go, you can't fall off!
	-- Jerry Moffat
