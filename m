Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270027AbTGNK2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270029AbTGNK2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:28:31 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:2784 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S270027AbTGNK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:28:30 -0400
X-Mailer: exmh 2.3 [17-Jan-2001] with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Reply-To: Elsner@zrz.TU-Berlin.DE, linux-kernel@vger.kernel.org
Comment: Software is like sex - it's better when it's free. --Linus Torvalds
Subject: [linux-2.6.0-test1] make xconfig fails
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jul 2003 12:43:17 +0200
From: Frank Elsner <Elsner@zrz.TU-Berlin.DE>
Message-Id: <E19c0nd-0006L9-4m@bronto.zrz.TU-Berlin.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


RHL 7.3, gcc-2.95.3, copied .config from 2.4.21 source tree 
                                      to linux-2.6.0-test1 source tree.
make oldconfig went ok.

Later make xconfig failed:

root: /usr/src/linux-2.6.0-test1<1059> make xconfig
  HOSTCC  scripts/fixdep
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 's/P(\([^,]*\),.*
/#define \1 (\*\1_p)/'
  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
/usr/lib/qt3-gcc2.96/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf
.moc
  HOSTCXX scripts/kconfig/qconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/qconf
./scripts/kconfig/qconf arch/i386/Kconfig
boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
#
# using defaults found in .config
#
make: *** [xconfig] Segmentation fault

Any pointer(s) welcome.


--Frank Elsner


