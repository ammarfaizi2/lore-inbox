Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTI2Eze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 00:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTI2Eze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 00:55:34 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:44416
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S262814AbTI2Ezc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 00:55:32 -0400
Message-Id: <200309290455.h8T4tVdd006356@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Test6: still an error in 'make install'
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Sep 2003 22:55:31 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the log file for the end of my build and install of -test6

---

  ...
  BUILD   arch/i386/boot/bzImage
Root device is (3, 7)
Boot sector 512 bytes.
Setup is 2544 bytes.
System is 1845 kB
Kernel: arch/i386/boot/bzImage is ready

[root@orion linux-2.6.0-test6]# make modules
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  Building modules, stage 2.
  MODPOST

[root@orion linux-2.6.0-test6]# make modules_install
Warning: you may need to install module-init-tools
See http://www.codemonkey.org.uk/post-halloween-2.5.txt
  INSTALL fs/binfmt_aout.ko
  INSTALL drivers/net/dummy.ko
  INSTALL drivers/base/firmware_class.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test6; fi

[root@orion linux-2.6.0-test6]# make install
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6 
arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.6.0-test6
mkinitrd failed
make[1]: *** [install] Error 1
make: *** [install] Error 2
[root@orion linux-2.6.0-test6]# 

---

note that the compile and build of the kernel finish with NO errors.
note that there are NO modules in this build.

Then note that there is some some silly error about:

    No module aic7xxx found for kernel 2.6.0-test6

during the 'make install' that causes the install to fail.

I have been seeing this error ever since -test1.
Has anyone tracked this thing down???

    
-- 
                                        Reg.Clemens
                                        reg@dwf.com


