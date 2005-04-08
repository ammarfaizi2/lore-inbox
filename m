Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVDHOMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVDHOMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVDHOMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:12:10 -0400
Received: from mail.portrix.net ([212.202.157.208]:37835 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262819AbVDHOMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:12:06 -0400
Message-ID: <42569122.9070003@portrix.net>
Date: Fri, 08 Apr 2005 16:11:46 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: 2.6.12-rc2-mm2
References: <20050408030835.4941cd98.akpm@osdl.org>
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> create-a-kstrdup-library-function.patch
>   create a kstrdup library function
> 
> create-a-kstrdup-library-function-fixes.patch
>   create-a-kstrdup-library-function-fixes

ppc defconfig build is broken due to this

make ARCH=ppc CROSS_COMPILE=powerpc-linux- O=/usr/src/ctest/mm/out/ppc
  CC      arch/ppc/boot/openfirmware/dummy.o
  GEN     arch/ppc/boot/openfirmware/image.o
  AS      arch/ppc/boot/openfirmware/coffcrt0.o
  CC      arch/ppc/boot/openfirmware/start.o
  AS      arch/ppc/boot/openfirmware/misc.o
  CC      arch/ppc/boot/openfirmware/common.o
  CC      arch/ppc/boot/openfirmware/coffmain.o
  COFF    arch/ppc/boot/openfirmware/coffboot
lib/lib.a(string.o)(.text+0x5cc): In function `kstrdup':
: undefined reference to `__kmalloc'
  COFF    arch/ppc/boot/images/vmlinux.coff
powerpc-linux-objcopy: 'arch/ppc/boot/openfirmware/coffboot': No such file
make[3]: *** [arch/ppc/boot/images/vmlinux.coff] Error 1
make[2]: *** [openfirmware] Error 2
make[1]: *** [zImage] Error 2
make: *** [_all] Error 2

See http://l4x.org/k/?d=3218

Jan
