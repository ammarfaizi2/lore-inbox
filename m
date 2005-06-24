Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbVFXTr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVFXTr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbVFXTry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:47:54 -0400
Received: from iron.pdx.net ([207.149.241.18]:5059 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S263378AbVFXTqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:46:20 -0400
Subject: PROBLEM 2.6.12-git6  CX88
From: Sean Bruno <sean.bruno@dsl-only.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jun 2005 12:46:17 -0700
Message-Id: <1119642377.3180.20.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempted to compile 2.6.12 with git6 today received the following error
on the cx88 module:

[root@home-desk linux-2.6.12]# make -j3 modules
  CHK     include/linux/version.h
  SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/media/video/cx88/cx88-core.o
  CC [M]  drivers/media/video/cx88/cx88-i2c.o
drivers/media/video/cx88/cx88-core.c:548: error: static declaration of
‘cx88_pci_irqs’ follows non-static declaration
drivers/media/video/cx88/cx88.h:438: error: previous declaration of
‘cx88_pci_irqs’ was here
make[4]: *** [drivers/media/video/cx88/cx88-core.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [drivers/media/video/cx88] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


Also, here is my gcc version info:
[root@home-desk linux-2.6.12]# gcc -v
Using built-in specs.
Target: x86_64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--enable-checking=release --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=c,c++,objc,java,f95,ada --enable-java-awt=gtk
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--host=x86_64-redhat-linux
Thread model: posix
gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)


