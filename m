Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130362AbRAXTpx>; Wed, 24 Jan 2001 14:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAXTpm>; Wed, 24 Jan 2001 14:45:42 -0500
Received: from ozob.net ([216.131.4.130]:42112 "EHLO ozob.net")
	by vger.kernel.org with ESMTP id <S130362AbRAXTpf>;
	Wed, 24 Jan 2001 14:45:35 -0500
Date: Wed, 24 Jan 2001 13:45:30 -0600 (CST)
From: ebi4 <ebi4@ozob.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10 configure/compile problem
Message-ID: <Pine.LNX.3.96.1010124133348.746B-100000@ozob.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFter a make mrproper then make menuconfig I get this:

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux-2.4.1-pre10/scripts/lxdialog'
/usr/bin/ld: warning: cannot find entry symbol _start; defaulting to
08048330
make[1]: Leaving directory `/usr/src/linux-2.4.1-pre10/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/i386/config.in
Using defaults found in arch/i386/defconfig
Preparing scripts: functions,
parsing...............................................................done.

and configure stalls there.

If I do a make xconfig I get this:

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.1-pre10/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
make[1]: *** [kconfig.tk] Error 132
make[1]: Leaving directory `/usr/src/linux-2.4.1-pre10/scripts'
make: *** [xconfig] Error 2

Then I can do a make config and that seems to work ok however I then do a
make dep and get:

make[1]: Entering directory `/usr/src/linux-2.4.1-pre10/arch/i386/boot'
make[1]: Nothing to be done for `dep'.
make[1]: Leaving directory `/usr/src/linux-2.4.1-pre10/arch/i386/boot'
scripts/mkdep init/*.c > .depend
make: *** [dep-files] Error 132

That's about as far as I can go.

The computer in question is a Sony SR7K which worked fine on 2.4.0-test12.

Can anyone enlighten me as to what the problem is here?

Thanks,

::::: Gene Imes			     http://www.ozob.net :::::

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
