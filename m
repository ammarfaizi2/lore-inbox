Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWHFPVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWHFPVB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWHFPVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:21:01 -0400
Received: from mx10.go2.pl ([193.17.41.74]:58773 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751242AbWHFPVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:21:00 -0400
Message-ID: <44D608AD.8000802@o2.pl>
Date: Sun, 06 Aug 2006 17:20:13 +0200
From: "lkml@o2.pl / IMAP" <lkml@o2.pl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060623)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found dependency error while compiling 2.6.18-rc3-mm2 kernel into
another directory...


estibi@amilo /home/place/linux-2.6.18-rc3-mm2> make V=1
O=../linux-2.6.18-rc3-mm2_amilo_obj menuconfig

make -C /home/place/linux-2.6.18-rc3-mm2_amilo_obj \
KBUILD_SRC=/home/place/linux-2.6.18-rc3-mm2 \
KBUILD_EXTMOD="" -f /home/place/linux-2.6.18-rc3-mm2/Makefile menuconfig
make -f /home/place/linux-2.6.18-rc3-mm2/scripts/Makefile.build
obj=scripts/basic
/bin/sh /home/place/linux-2.6.18-rc3-mm2/scripts/mkmakefile \
    /home/place/linux-2.6.18-rc3-mm2
/home/place/linux-2.6.18-rc3-mm2_amilo_obj 2 6
  GEN     /home/place/linux-2.6.18-rc3-mm2_amilo_obj/Makefile
mkdir -p include/linux include/config
make -f /home/place/linux-2.6.18-rc3-mm2/scripts/Makefile.build
obj=scripts/kconfig menuconfig
  gcc -Wp,-MD,scripts/kconfig/lxdialog/.checklist.o.d -Iscripts/kconfig
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE -c -o
scripts/kconfig/lxdialog/checklist.o
/home/place/linux-2.6.18-rc3-mm2/scripts/kconfig/lxdialog/checklist.c
/home/place/linux-2.6.18-rc3-mm2/scripts/kconfig/lxdialog/checklist.c:325:
fatal error: opening dependency file
scripts/kconfig/lxdialog/.checklist.o.d: Nie ma takiego pliku ani katalogu
compilation terminated.
make[2]: *** [scripts/kconfig/lxdialog/checklist.o] Bd 1
make[1]: *** [menuconfig] Bd 2
make: *** [menuconfig] Bd 2



Best Regards!

Piotr Jasiukajtis

