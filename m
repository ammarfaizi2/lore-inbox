Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbSIVKDG>; Sun, 22 Sep 2002 06:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSIVKDG>; Sun, 22 Sep 2002 06:03:06 -0400
Received: from inet-mail2.oracle.com ([148.87.2.202]:31180 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S262693AbSIVKDD>; Sun, 22 Sep 2002 06:03:03 -0400
Message-ID: <3D8D95FE.1090700@oracle.com>
Date: Sun, 22 Sep 2002 12:05:50 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.5.38] floppy.c doesn't compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/local/src/linux-2.5.38/drivers/block'
   gcc -Wp,-MD,./.floppy.o.d -D__KERNEL__ 
-I/usr/local/src/linux-2.5.38/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 
-I/usr/local/src/linux-2.5.38/arch/i386/mach-generic -nostdinc 
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=floppy   -c -o 
floppy.o floppy.c
floppy.c: In function `cleanup_module':
floppy.c:4565: `drive' undeclared (first use in this function)
floppy.c:4565: (Each undeclared identifier is reported only once
floppy.c:4565: for each function it appears in.)
floppy.c:4559: warning: unused variable `i'
floppy.c:4573: warning: statement with no effect
make[2]: *** [floppy.o] Error 1
make[2]: Leaving directory `/usr/local/src/linux-2.5.38/drivers/block'
make[1]: *** [block] Error 2
make[1]: Leaving directory `/usr/local/src/linux-2.5.38/drivers'
make: *** [drivers] Error 2

It is quite obvious that 'i' should be replaced with 'drive'
  at line 4559 (this makes it build) - however the "statement
  with no effect" stays. It's late, i have to catch a plane
  back to Italy in a few hours so I can't debug further...

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

