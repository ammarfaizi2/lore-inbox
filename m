Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJLWK7>; Sat, 12 Oct 2002 18:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbSJLWK6>; Sat, 12 Oct 2002 18:10:58 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:61371 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261264AbSJLWK6> convert rfc822-to-8bit; Sat, 12 Oct 2002 18:10:58 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.42 (-mm): IDE as modules NO go
Date: Sun, 13 Oct 2002 00:16:41 +0200
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210130016.41348.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f drivers/ide/Makefile
  gcc -Wp,-MD,drivers/ide/.ide.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -mcpu=k6 -march=i686 -malign-functions=4 
-fschedule-insns2 -fexpensive-optimizations  -Iarch/i386/mach-generic 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE -include 
include/linux/modversions.h   -DKBUILD_BASENAME=ide -DEXPORT_SYMTAB  -c -o 
drivers/ide/ide.o drivers/ide/ide.c
drivers/ide/ide.c: In function `ide_register_driver_Rsmp_968faa65':
drivers/ide/ide.c:3459: warning: assignment discards qualifiers from pointer 
target type
drivers/ide/ide.c: At top level:
drivers/ide/ide.c:3563: redefinition of `init_module'
drivers/ide/ide.c:3541: `init_module' previously defined here
drivers/ide/ide.c: In function `cleanup_module':
drivers/ide/ide.c:3585: warning: implicit declaration of function 
`bus_unregister'
{standard input}: Assembler messages:
{standard input}:9110: Error: symbol `init_module' is already defined
make[2]: *** [drivers/ide/ide.o] Error 1
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

Thanks,
	Dieter
