Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSDSUEP>; Fri, 19 Apr 2002 16:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSDSUEO>; Fri, 19 Apr 2002 16:04:14 -0400
Received: from mpdr0.chicago.il.ameritech.net ([67.38.100.19]:42122 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S312256AbSDSUEN>; Fri, 19 Apr 2002 16:04:13 -0400
Message-ID: <3CC0790F.2070400@ameritech.net>
Date: Fri, 19 Apr 2002 15:07:43 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre7-ac1
In-Reply-To: <200204190916.g3J9G0b01318@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
   With this version "make xconfig" appears to break:




make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.19-pre7-ac1/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o 
tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/char/Config.in: 265: can't handle 
dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.19-pre7-ac1/scripts'
make: *** [xconfig] Error 2



