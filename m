Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbRL3ORI>; Sun, 30 Dec 2001 09:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287422AbRL3OQ7>; Sun, 30 Dec 2001 09:16:59 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:23923 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287421AbRL3OQj>; Sun, 30 Dec 2001 09:16:39 -0500
Date: Sun, 30 Dec 2001 15:17:31 +0100
From: Heinz Diehl <hd@cavy.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix serial close hang
Message-ID: <20011230141731.GA7314@elfie.cavy.de>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011230135249.A9625@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011230135249.A9625@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.24-current-20011226i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Dec 30 2001, Russell King wrote:

> Comments welcome.

Patch applies flawlessly to 2.4.17, however compilation fails:

[....]
make[2]: Leaving directory /usr/src/linux/drivers/cdrom'
make -C char modules
make[2]: Entering directory /usr/src/linux/drivers/char'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE   -DEXPORT_SYMTAB -c
serial.c
serial.c: In function get_async_struct':
serial.c:3131: state' undeclared (first use in this function)
serial.c:3131: (Each undeclared identifier is reported only once
serial.c:3131: for each function it appears in.)
make[2]: *** [serial.o] Error 1
make[2]: Leaving directory /usr/src/linux/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory /usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2
elfie:/usr/src/linux #

-- 
# Heinz Diehl, 68259 Mannheim, Germany
