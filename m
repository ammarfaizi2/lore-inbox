Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTBXU50>; Mon, 24 Feb 2003 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbTBXU50>; Mon, 24 Feb 2003 15:57:26 -0500
Received: from t2s5.tele2.cz ([213.246.64.40]:21182 "HELO t2s5.tele2.cz")
	by vger.kernel.org with SMTP id <S267385AbTBXU5Z>;
	Mon, 24 Feb 2003 15:57:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: rmk@arm.linux.org.uk
Subject: can't compile
Date: Mon, 24 Feb 2003 22:06:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18nPoV-0000XD-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted compile my own kernel for iPAQ 3630 - 2.4.21 - because of new 
Bluetooth rfcomm.o support and other things, but I can't go nor through 
menuconfig :( My original platform is i386 (Intel Pentium III) - debian woody 
3.0r1

Liboc01:/usr/src/linux# make menuconfig ARCH=arm
rm -f include/asm-arm/arch include/asm-arm/proc
(cd include/asm-arm; ln -sf arch- arch; ln -sf proc- proc)
rm -f include/asm
( cd include ; ln -sf asm-arm asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux-2.4.20/scripts/lxdialog'
make[1]: Leaving directory `/usr/src/linux-2.4.20/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/arm/config.in
Using defaults found in arch/arm/defconfig
Preparing scripts: functions, parsingscripts/Menuconfig: line 1:   820 
Segmentation fault      awk "$1"
Awk died with error code 139. Giving up.
make: *** [menuconfig] Error 1

ARCH=ppc for example goes right
problem under 2.4.19, 2.4.20, 2.4.21-pre4 - older kernels I didn't tried

Michal
