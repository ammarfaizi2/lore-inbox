Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbQLEKXE>; Tue, 5 Dec 2000 05:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130613AbQLEKWy>; Tue, 5 Dec 2000 05:22:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7281 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130599AbQLEKWu>; Tue, 5 Dec 2000 05:22:50 -0500
Subject: Re: Problems with Athlon CPU
To: lukasz@lt.wsisiz.edu.pl (Lukasz Trabinski)
Date: Tue, 5 Dec 2000 09:52:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012050945.eB59jYu01739@lt.wsisiz.edu.pl> from "Lukasz Trabinski" at Dec 05, 2000 10:45:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143Eln-00050X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In article <Pine.LNX.4.30.0012042315410.620-100000@asdf.capslock.lan> y=
> ou wrote:
> > ^^^^^^^^^^^^^^^^
> 
> > You can't build a kernel with that compiler.  You _must_ use gcc
> > 2.91.66 or another compiler that can compile the kernel.  Red Hat
> > ships gcc 2.91.66 packaged as "kgcc" for kernel builds as do
> > other major vendors.
> 
> Huh, no way, I have tried also with kgcc:

Then I can only conclude your system is broken in some way since it works
for everyone else

> [root@beer linux]# cat Makefile |grep gcc
> HOSTCC          =3Dkgcc

HOSTCC should be gcc, CC should be kgcc. HOSTCC=kgcc should be fairly
harmless

> make[2]: Leaving directory `/usr/src/linux/drivers/net'
> make[1]: *** [_subdir_net] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_dir_drivers] Error 2
> 
> and I would like also to say, that problem doeas not exists with glibc
> and glibc-devel 2.1.94.

glibc is not linked with the kernel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
