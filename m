Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbQLEKQy>; Tue, 5 Dec 2000 05:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbQLEKQp>; Tue, 5 Dec 2000 05:16:45 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:52750 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S130570AbQLEKQ2>; Tue, 5 Dec 2000 05:16:28 -0500
Date: Tue, 5 Dec 2000 10:45:34 +0100
Message-Id: <200012050945.eB59jYu01739@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with Athlon CPU
In-Reply-To: <Pine.LNX.4.30.0012042315410.620-100000@asdf.capslock.lan>
X-Newsgroups: lt.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.4.0-test11 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0012042315410.620-100000@asdf.capslock.lan> you wrote:
> ^^^^^^^^^^^^^^^^

> You can't build a kernel with that compiler.  You _must_ use gcc
> 2.91.66 or another compiler that can compile the kernel.  Red Hat
> ships gcc 2.91.66 packaged as "kgcc" for kernel builds as do
> other major vendors.

Huh, no way, I have tried also with kgcc:
[root@beer linux]# cat Makefile |grep gcc
HOSTCC          =kgcc
#       foo-bar-gcc for cross builds
#       gcc272 for Debian's old compiler for kernels
#       kgcc for Conectiva and Red Hat 7
CC      =$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)kgcc; else \
        $(CONFIG_SHELL) scripts/kwhich gcc272 2>/dev/null || $(CONFIG_SHELL) scripts/kwhich kgcc 2>/dev/null || echo cc; fi) \

after make bzImage:

/usr/src/linux/include/linux/signal.h: In function `siginitsetinv':
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
/usr/src/linux/include/linux/signal.h:201: parse error before `)'
make[3]: *** [auto_irq.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

and I would like also to say, that problem doeas not exists with glibc
and glibc-devel 2.1.94.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
