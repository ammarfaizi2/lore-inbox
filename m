Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbRHPACV>; Wed, 15 Aug 2001 20:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRHPACL>; Wed, 15 Aug 2001 20:02:11 -0400
Received: from c1765315-a.mckiny1.tx.home.com ([65.10.75.71]:260 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id <S268537AbRHPABy> convert rfc822-to-8bit;
	Wed, 15 Aug 2001 20:01:54 -0400
Subject: Alpha pc_keyb.c compile broken in 2.4.9-pre3
Date: Wed, 15 Aug 2001 19:02:07 -0500
Message-ID: <C033B4C3E96AF74A89582654DEC664DB54D3@aruba.maner.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Alpha pc_keyb.c compile broken in 2.4.9-pre3
Thread-Index: AcEl5rCV05YCG+tMR5WhPo1LsOqP9Q==
content-class: urn:content-classes:message
From: "Donald Maner" <donjr@maner.org>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -DEXPORT_SYMTAB -c
keyboard.c
In file included from keyboard.c:36:
/home/donjr/linux/include/asm/keyboard.h:25: warning: `struct
kbd_repeat' declared inside parameter list
/home/donjr/linux/include/asm/keyboard.h:25: warning: its scope is only
this definition or declaration, which is probably not what you want.
gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -c -o defkeymap.o
defkeymap.c
gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -c -o pc_keyb.o
pc_keyb.c
In file included from pc_keyb.c:36:
/home/donjr/linux/include/asm/keyboard.h:25: warning: `struct
kbd_repeat' declared inside parameter list
/home/donjr/linux/include/asm/keyboard.h:25: warning: its scope is only
this definition or declaration, which is probably not what you want.
pc_keyb.c:539: variable `kbdrate' has initializer but incomplete type
pc_keyb.c:540: warning: excess elements in struct initializer
pc_keyb.c:540: warning: (near initialization for `kbdrate')
pc_keyb.c:542: warning: excess elements in struct initializer
pc_keyb.c:542: warning: (near initialization for `kbdrate')
pc_keyb.c: In function `parse_kbd_rate':
pc_keyb.c:568: dereferencing pointer to incomplete type
pc_keyb.c:569: dereferencing pointer to incomplete type
pc_keyb.c:569: invalid use of undefined type `struct kbd_repeat'
pc_keyb.c:570: dereferencing pointer to incomplete type
pc_keyb.c:571: dereferencing pointer to incomplete type
pc_keyb.c:571: invalid use of undefined type `struct kbd_repeat'
pc_keyb.c:573: dereferencing pointer to incomplete type
pc_keyb.c:579: dereferencing pointer to incomplete type
pc_keyb.c:584: dereferencing pointer to incomplete type
pc_keyb.c:585: dereferencing pointer to incomplete type
pc_keyb.c: At top level:
pc_keyb.c:600: conflicting types for `pckbd_rate'
/home/donjr/linux/include/asm/keyboard.h:25: previous declaration of
`pckbd_rate'
pc_keyb.c: In function `pckbd_rate':
pc_keyb.c:605: storage size of `old_rep' isn't known
pc_keyb.c:606: sizeof applied to an incomplete type
pc_keyb.c:608: sizeof applied to an incomplete type
pc_keyb.c:609: sizeof applied to an incomplete type
pc_keyb.c:605: warning: unused variable `old_rep'
make[3]: *** [pc_keyb.o] Error 1
make[3]: Leaving directory `/home/donjr/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/donjr/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/home

