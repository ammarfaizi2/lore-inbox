Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbREaL2C>; Thu, 31 May 2001 07:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263072AbREaL1w>; Thu, 31 May 2001 07:27:52 -0400
Received: from mail.onet.pl ([213.180.128.16]:2516 "EHLO marlin.onet.pl")
	by vger.kernel.org with ESMTP id <S263070AbREaL1p>;
	Thu, 31 May 2001 07:27:45 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: robert seczkowski <j_red@sz.onet.pl>
Reply-To: j_red@sz.onet.pl
To: kaos@ocs.com.au
Subject: kernel
Date: Thu, 31 May 2001 13:31:56 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01053113302200.01722@laptop>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problem with kernel 2.4.2 from red hat 7.2 distribution.
This problem appears when I type make modules.
and it seems like compiler doesn't understand extern in function
declaration
gcc version 2.96 20000731
Thanks in advance

below log:



make -C  kernel CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4/include -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-Wno-unused -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.4/include/linux/modversions.h" 
MAKING_MODULES=1 modules
make[1]: Wchodzê katalog `/home/linux-2.4.2/kernel'
make[1]: Nie nic do roboty w `modules'.
make[1]: Opuszczam katalog `/home/linux-2.4.2/kernel'
make -C  drivers CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4/include -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-Wno-unused -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.4/include/linux/modversions.h" 
MAKING_MODULES=1 modules
make[1]: Wchodzê katalog `/home/linux-2.4.2/drivers'
make -C block modules
make[2]: Wchodzê katalog `/home/linux-2.4.2/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -fno-common -Wno-unused -pipe 
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4/include/linux/modversions.h   -c -o floppy.o floppy.c
In file included from /usr/src/linux-2.4/include/linux/spinlock.h:35,
                 from /usr/src/linux-2.4/include/linux/module.h:11,
                 from floppy.c:137:
/usr/src/linux-2.4/include/asm/spinlock.h:8: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/asm/spinlock.h:8: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/asm/spinlock.h:8: parse error before `1b7d4074'
/usr/src/linux-2.4/include/asm/spinlock.h:9: `printk_R_ver_str' declared as 
function returning a function
/usr/src/linux-2.4/include/asm/spinlock.h:9: warning: function declaration 
isn't a prototype
In file included from floppy.c:137:
/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:173: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:173: parse error before `62dada05'
/usr/src/linux-2.4/include/linux/module.h:173: 
`inter_module_register_R_ver_str' declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:173: warning: function declaration 
isn't a prototype
/usr/src/linux-2.4/include/linux/module.h:174: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:174: missing white space after 
number `7a9e845'
/usr/src/linux-2.4/include/linux/module.h:174: parse error before `7a9e845'
/usr/src/linux-2.4/include/linux/module.h:174: 
`inter_module_unregister_R_ver_str' declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:174: warning: function declaration 
isn't a prototype
/usr/src/linux-2.4/include/linux/module.h:175: `inter_module_get_R_ver_str' 
declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:175: warning: parameter names 
(without types) in function declaration
/usr/src/linux-2.4/include/linux/module.h:176: 
`inter_module_get_request_R_ver_str' declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:176: warning: parameter names 
(without types) in function declaration
/usr/src/linux-2.4/include/linux/module.h:177: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:177: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:177: nondigits in number and not 
hexadecimal
/usr/src/linux-2.4/include/linux/module.h:177: parse error before `6b99f7d8'
/usr/src/linux-2.4/include/linux/module.h:177: `inter_module_put_R_ver_str' 
declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:177: warning: function declaration 
isn't a prototype
/usr/src/linux-2.4/include/linux/module.h:186: `try_inc_mod_count_R_ver_str' 
declared as function returning a function
/usr/src/linux-2.4/include/linux/module.h:186: warning: parameter names 
(without types) in function declaration
make[2]: *** [floppy.o] B³±d 1
make[2]: Opuszczam katalog `/home/linux-2.4.2/drivers/block'
make[1]: *** [_modsubdir_block] B³±d 2
make[1]: Opuszczam katalog `/home/linux-2.4.2/drivers'
make: *** [_mod_drivers] B³±d 2
