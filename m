Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTJHWco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJHWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:32:44 -0400
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:13998 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261807AbTJHWcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:32:42 -0400
Message-ID: <3F849088.7010105@steudten.com>
Date: Thu, 09 Oct 2003 00:32:40 +0200
From: Thomas Steudten <alpha@steudten.com>
Reply-To: alpha@steudten.com
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: linux-2.6.0-test7: make O=/var/tmp/build xconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Maybe i´m not up-to-date, but i tried out the new 2.6 kernel
with the new O option and it fails with:
I think here´s something wrong, one -I is missing between
the //: -I/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7//usr/lib/qt-2.3.1/include

--------------------8<-------------------8<--------------
[62]:thomas (2) $ make  -w V=1 O=/var/tmp/build xconfig
make: Entering directory `/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7'
make -C /var/tmp/build          \
KBUILD_SRC=/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7       KBUILD_VERBOSE=1        \
KBUILD_CHECK= -f /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/Makefile xconfig
make -f /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/Makefile.build obj=scripts scripts/fixdep
make[2]: `scripts/fixdep' is up to date.
make -f /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/Makefile.build obj=scripts/kconfig xconfig
-->  g++ -Wp,-MD,scripts/kconfig/.qconf.o.d  -O2  -I/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7//usr/lib/qt-2.3.1/include -c -o scripts/kconf
ig/qconf.o /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:6: qapplication.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:7: qmainwindow.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:8: qtoolbar.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:9: qvbox.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:10: qsplitter.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:11: qlistview.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:12: qtextview.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:13: qlineedit.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:14: qmenubar.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:15: qmessagebox.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:16: qaction.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:17: qheader.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:18: qfiledialog.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:19: qregexp.h: No such file or directory
In file included from /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:26:
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/lkc.h:18: lkc_defs.h: No such file or directory
In file included from /usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:27:
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.h:6: qlistview.h: No such file or directory
/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7/scripts/kconfig/qconf.cc:29: qconf.moc: No such file or directory
make[2]: *** [scripts/kconfig/qconf.o] Error 1
make[1]: *** [xconfig] Error 2
make: *** [xconfig] Error 2
make: Leaving directory `/usr/src/linux_dir/kernel2.6/linux-2.6.0-test7'


---
Tom



