Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277053AbRJKXWy>; Thu, 11 Oct 2001 19:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277054AbRJKXWp>; Thu, 11 Oct 2001 19:22:45 -0400
Received: from CPE-61-9-149-34.vic.bigpond.net.au ([61.9.149.34]:34037 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S277053AbRJKXWd>; Thu, 11 Oct 2001 19:22:33 -0400
Message-ID: <3BC62542.CDEAAE@eyal.emu.id.au>
Date: Fri, 12 Oct 2001 09:03:30 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.13-pre1: sonypi.c compile error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h  
-DEXPORT_SYMTAB -c sonypi.c
sonypi.c: In function `sonypi_init_module':
sonypi.c:702: `is_sony_vaio_laptop_R7462d5e4' undeclared (first use in
this function)
sonypi.c:702: (Each undeclared identifier is reported only once
sonypi.c:702: for each function it appears in.)
make[2]: *** [sonypi.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/char'

Now this is what we have here, I can not figure the intentions of the
author:

static int __init sonypi_init_module(void) {
        if (is_sony_vaio_laptop)
                return pci_module_init(&sonypi_driver);
        else
                return -ENODEV;
}

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
