Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTIIKGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIIKGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:06:48 -0400
Received: from mux.spb.co.ru ([62.105.151.40]:6817 "EHLO mux.spb.co.ru")
	by vger.kernel.org with ESMTP id S263985AbTIIKGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:06:46 -0400
Message-ID: <000701c376ba$11e87ef0$370101c8@antontest>
From: "Anton Kholodenin" <cicprogr@mail.dux.ru>
To: <mec@shout.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Make Menuconfig and Make Xconfig errors in Mandrake 9.2 rc1
Date: Tue, 9 Sep 2003 14:06:42 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find 2 errors in Mandrake 9.2 rc 1

1. If I do  cd /usr/src/linux; make menuconfig (kernel-source-2.4.22-1mdk
package has been preliminary installed) and go to section Sound->Advanced
Linux Sound Architecture, program terminated with message:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu76: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

2. If i do cd /usr/src/linux; make xconfig program not started and write to
console:

rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
if [ -f .need_mrproper ]; then \
        rm .need_mrproper; \
        make mrproper;  \
        make preconfig;  \
fi
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.22-1mdk/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
3rdparty/lufs/Config.in: 2: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.22-1mdk/scripts'
make: *** [xconfig] Error 2

Pls, Inform how to correct it and correct it in final release.

Best Regards.
Anton Kholodenin
SystemAdministrator
Telenor-Combellga Russia Inc.



