Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTAQNkU>; Fri, 17 Jan 2003 08:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbTAQNkU>; Fri, 17 Jan 2003 08:40:20 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:13320 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id <S267515AbTAQNkS>; Fri, 17 Jan 2003 08:40:18 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200301171349.IAA32603@clem.clem-digital.net>
Subject: 2.5.59 fails compile 3c509.c
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Fri, 17 Jan 2003 08:49:15 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

  gcc -Wp,-MD,drivers/net/.3c509.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3c509 -DKBUILD_MODNAME=3c509   -c -o drivers/net/3c509.o drivers/net/3c509.c
drivers/net/3c509.c: In function `el3_probe':
drivers/net/3c509.c:584: warning: label `found' defined but not used
drivers/net/3c509.c: In function `el3_close':
drivers/net/3c509.c:1083: structure has no member named `edev'
drivers/net/3c509.c: At top level:
drivers/net/3c509.c:268: warning: `nopnp' defined but not used
make[2]: *** [drivers/net/3c509.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

-- 
Pete Clements 
clem@clem.clem-digital.net
