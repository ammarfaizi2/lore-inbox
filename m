Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSLCK2k>; Tue, 3 Dec 2002 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSLCK2k>; Tue, 3 Dec 2002 05:28:40 -0500
Received: from port-212-202-177-38.reverse.qdsl-home.de ([212.202.177.38]:1796
	"EHLO camelot.fbunet.de") by vger.kernel.org with ESMTP
	id <S266200AbSLCK2j> convert rfc822-to-8bit; Tue, 3 Dec 2002 05:28:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fridtjof Busse <fridtjof@fbunet.de>
To: linux-kernel@vger.kernel.org
Subject: Compile error with 2.4.20-ac1
Date: Tue, 3 Dec 2002 11:35:49 +0100
X-OS: Linux on i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031135.49423@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
If I change an option (make menuconfig) and run 'make dep && make clean 
bzImage modules modules_install' afterwards, I get:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=compat  -c -o compat.o compat.c
make[3]: *** No rule to make target 
`/usr/src/linux-2.4.20/drivers/pci/devlist.h', needed by `names.o'.  
Stop.
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make: *** [_dir_drivers] Error 2

If I run 'make dep && make clean bzImage modules modules_install' again, 
without changing anything, the compilation doesn't give any errors and 
the kernel runs fine.
But if I again change an option, same thing happens.

-- 
Fridtjof Busse
BOFH excuse #185:
system consumed all the paper for paging


