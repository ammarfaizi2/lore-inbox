Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTEFIVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTEFIVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:21:11 -0400
Received: from [200.171.183.235] ([200.171.183.235]:29405 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id S262431AbTEFIVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:21:09 -0400
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
Subject: [PATCH] 2.5.69 - vsyscall DSO implementation require as/binutils >= 2.12
Date: Tue, 6 May 2003 05:37:57 -0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305060537.57628.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[root@quarks linux-2.5.69]: make bzImage
(....)
  gcc -Wp,-MD,arch/i386/kernel/.vsyscall.o.d -D__ASSEMBLY__ -D__KERNEL__ -Iinclude -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include  -traditional  -c -o arch/i386/kernel/vsyscall.o arch/i386/kernel/vsyscall.S
/root/tmp/ccJ8vZaj.s: Assembler messages:
/root/tmp/ccJ8vZaj.s:2003: Error: Unknown pseudo-op:  `.incbin'
/root/tmp/ccJ8vZaj.s:2008: Error: Unknown pseudo-op:  `.incbin'
make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
make: *** [arch/i386/kernel] Error 2
[root@quarks linux-2.5.69]: ld -v
GNU ld version 2.11.2 (with BFD 2.11.2)
[root@quarks linux-2.5.69]: grep -r binutils Documentation/Changes
o  binutils               2.9.5.0.25              # ld -v
release of binutils.
o  <ftp://ftp.kernel.org/pub/linux/devel/binutils/>

from binutils-2.14.90.0.1/gas/NEWS :

Changes in 2.12:
(...)
* New psuedo op: .incbin to include a set of binary data at a given point
  in the assembly.  Contributed by Anders Norlander.

Patch :

--- Documentation/Changes	Tue May  6 04:18:37 2003
+++ Documentation/Changes	Tue May  6 04:18:37 2003
@@ -50,7 +50,7 @@
 
 o  Gnu C                  2.95.3                  # gcc --version
 o  Gnu make               3.78                    # make --version
-o  binutils               2.9.5.0.25              # ld -v
+o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  module-init-tools      0.9.9                   # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
-


cya;

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Brazil                   
	 _________________________


