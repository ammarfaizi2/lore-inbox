Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUBETEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUBETCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:02:38 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:28429 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266508AbUBETAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:00:00 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Thu, 5 Feb 2004 21:51:03 +0300
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-mm1 [: make xconfig crash in Mdk 10.0 beta2]
Message-ID: <20040205185103.GD5320@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it in Mandrake only or generic problem?

----- Forwarded message from  -----

Date: Thu, 5 Feb 2004 21:48:17 +0300
To: cooker@linux-mandrake.com
Subject: make xconfig crasj in beta2
User-Agent: Mutt/1.5.5.1i

{pts/0}% makelinux xconfig
make: Entering directory `/home/bor/src/linux-2.6.2-mm1'
  HOSTCC  scripts/fixdep
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
sed < /home/bor/src/linux-2.6.2-mm1/scripts/kconfig/lkc_proto.h >
scripts/kconfig/lkc_defs.h 's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
/usr/lib/qt3//bin/moc -i
/home/bor/src/linux-2.6.2-mm1/scripts/kconfig/qconf.h -o
scripts/kconfig/qconf.moc
  HOSTCXX scripts/kconfig/qconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/qconf
scripts/kconfig/qconf arch/i386/Kconfig
make[2]: *** [xconfig] Segmentation fault
make[1]: *** [xconfig] Error 2
make: *** [xconfig] Error 2
make: Leaving directory `/home/bor/src/linux-2.6.2-mm1'

this is with patch that fixes make xconfig in separate build directory
(it is still broken); but it worked just fine before.

----- End forwarded message -----
