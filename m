Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTHTFkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 01:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbTHTFkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 01:40:13 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:44417
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S261717AbTHTFkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 01:40:08 -0400
Message-Id: <200308200540.h7K5e7xW006280@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
From: clemens@dwf.com
Subject: Why do I get this error building 2.6.0-test3 ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Aug 2003 23:40:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I build 2.6.0-test3 the compiles (kernel and modules) are
clean, and the install of the modules only complains about some
unresolved symbols in the sound system (Ill check on that next).

However the 'make install' gives the following output:

---

[root@orion linux-2.6.0-test3]# make install
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.6.0-test3 arch/i386/boot/bzImage System.map ""
No module aic7xxx found for kernel 2.6.0-test3
make[1]: *** [install] Error 1
make: *** [install] Error 2
[root@orion linux-2.6.0-test3]# 

---

I have specified the aic7xxx SCSI driver as a *module* so what is the
complaint here while building the kernel???

I have tried a number of alternatives, but always this message.
The kernel does run (havent checked the SCSI devices yet), but find
this message strange...

And yes, there is a module aic7xxx.ko over in /lib/modules/...


-- 
                                        Reg.Clemens
                                        reg@dwf.com


