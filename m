Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280823AbRKBUml>; Fri, 2 Nov 2001 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKBUma>; Fri, 2 Nov 2001 15:42:30 -0500
Received: from [212.34.128.4] ([212.34.128.4]:17962 "EHLO mailer.ran.es")
	by vger.kernel.org with ESMTP id <S280824AbRKBUmT>;
	Fri, 2 Nov 2001 15:42:19 -0500
Date: Fri, 2 Nov 2001 21:42:25 +0100
From: victor <ixnay@infonegocio.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: victor <ixnay@infonegocio.com>
X-Priority: 3 (Normal)
Message-ID: <10487549890.20011102214225@infonegocio.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.2.20 falis on alpha
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

2.2.19 compiles me perfectly but 2.2.20 fails ...

alpha:/usr/src/linux# uname -a
Linux alpha 2.2.18pre21 #1 Wed Nov 22 05:08:09 CST 2000 alpha unknown
alpha:/usr/src/linux# make
make: Circular /usr/src/linux/include/asm/smp.h <- /usr/src/linux/include/linux/sched.h dependency dropped.
make: Circular /usr/src/linux/include/asm/pci.h <- /usr/src/linux/include/linux/pci.h dependency dropped.
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8  -c -o init/main.o init/main.c
In file included from /usr/src/linux/include/linux/pci.h:1448,
                 from init/main.c:35:
/usr/src/linux/include/asm/pci.h: In function `pci_controller_num':
/usr/src/linux/include/asm/pci.h:62: structure has no member named `pci_host_index'
/usr/src/linux/include/asm/pci.h:63: warning: control reaches end of non-void function
make: *** [init/main.o] Error 1
alpha:/usr/src/linux# dpkg -la |grep libc
ii  libc6.1        2.2.4-4        GNU C Library: Shared libraries and Timezone
ii  libc6.1-dbg    2.2.4-4        GNU C Library: Libraries with debugging symb
ii  libc6.1-dev    2.2.4-4        GNU C Library: Development Libraries and Hea
ii  libc6.1-pic    2.2.4-4        GNU C Library: PIC archive library
ii  libc6.1-prof   2.2.4-4        GNU C Library: Profiling Libraries.
ii  libgpmg1       1.17.8-18      General Purpose Mouse Library [libc6]
alpha:/usr/src/linux# exit  

-- 
Best regards,
 victor                          mailto:ixnay@infonegocio.com

