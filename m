Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSK1B2L>; Wed, 27 Nov 2002 20:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSK1B2K>; Wed, 27 Nov 2002 20:28:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7157 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265039AbSK1B2J>; Wed, 27 Nov 2002 20:28:09 -0500
Date: Thu, 28 Nov 2002 02:35:27 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christer Weinigel <wingel@nano-system.com>
Cc: linux-kernel@vger.kernel.org
Subject: scx200_gpio.c doesn't compile in 2.5.50
Message-ID: <20021128013527.GU21307@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation of drivers/char/scx200_gpio.c fails in 2.5.50 with the error
messages below.

cu
Adrian

<--  snip  -->

...
  gcc -Wp,-MD,drivers/char/.scx200_gpio.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=scx200_gpio
-DKBUILD_MODNAME=scx200_gpio   -c -o drivers/char/scx200_gpio.o drivers/char/scx200_gpio.c
drivers/char/scx200_gpio.c: In function `scx200_gpio_write':
drivers/char/scx200_gpio.c:31: warning: implicit declaration of function
`minor'
drivers/char/scx200_gpio.c:31: dereferencing pointer to incomplete type
drivers/char/scx200_gpio.c:34: dereferencing pointer to incomplete type
drivers/char/scx200_gpio.c: In function `scx200_gpio_read':
drivers/char/scx200_gpio.c:82: dereferencing pointer to incomplete type
drivers/char/scx200_gpio.c:85: dereferencing pointer to incomplete type
drivers/char/scx200_gpio.c: At top level:
drivers/char/scx200_gpio.c:95: warning: `struct inode' declared inside
parameter list
drivers/char/scx200_gpio.c:95: warning: its scope is only this
definition or declaration, which is probably not what you want.
drivers/char/scx200_gpio.c: In function `scx200_gpio_open':
drivers/char/scx200_gpio.c:97: dereferencing pointer to incomplete type
drivers/char/scx200_gpio.c: At top level:
drivers/char/scx200_gpio.c:103: warning: `struct inode' declared inside
parameter list
drivers/char/scx200_gpio.c:109: variable `scx200_gpio_fops' has
initializer but incomplete type
drivers/char/scx200_gpio.c:110: unknown field `owner' specified in
initializer
drivers/char/scx200_gpio.c:110: warning: excess elements in struct
initializer
drivers/char/scx200_gpio.c:110: warning: (near initialization for
`scx200_gpio_fops')
drivers/char/scx200_gpio.c:111: unknown field `write' specified in
initializer
drivers/char/scx200_gpio.c:111: warning: excess elements in struct
initializer
drivers/char/scx200_gpio.c:111: warning: (near initialization for
`scx200_gpio_fops')
drivers/char/scx200_gpio.c:112: unknown field `read' specified in
initializer
drivers/char/scx200_gpio.c:112: warning: excess elements in struct
initializer
drivers/char/scx200_gpio.c:112: warning: (near initialization for
`scx200_gpio_fops')
drivers/char/scx200_gpio.c:113: unknown field `open' specified in
initializer
drivers/char/scx200_gpio.c:113: warning: excess elements in struct
initializer
drivers/char/scx200_gpio.c:113: warning: (near initialization for
`scx200_gpio_fops')
drivers/char/scx200_gpio.c:114: unknown field `release' specified in
initializer
drivers/char/scx200_gpio.c:114: warning: excess elements in struct
initializer
drivers/char/scx200_gpio.c:114: warning: (near initialization for
`scx200_gpio_fops')
drivers/char/scx200_gpio.c: In function `scx200_gpio_init':
drivers/char/scx200_gpio.c:128: warning: implicit declaration of
function `register_chrdev'
drivers/char/scx200_gpio.c: In function `scx200_gpio_cleanup':
drivers/char/scx200_gpio.c:143: warning: implicit declaration of
function `unregister_chrdev'
make[2]: *** [drivers/char/scx200_gpio.o] Error 1

<--  snip  -->
