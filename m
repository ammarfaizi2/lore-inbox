Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271659AbRHQVRn>; Fri, 17 Aug 2001 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271694AbRHQVRe>; Fri, 17 Aug 2001 17:17:34 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:26384 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271720AbRHQVRX>; Fri, 17 Aug 2001 17:17:23 -0400
Date: Fri, 17 Aug 2001 16:17:36 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Donald Maner <donjr@maner.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Alpha pc_keyb.c compile broken in 2.4.9-pre3
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB54D3@aruba.maner.org>
Message-ID: <Pine.LNX.3.96.1010817161650.19954B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Donald Maner wrote:

> gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -DEXPORT_SYMTAB -c
> keyboard.c
> In file included from keyboard.c:36:
> /home/donjr/linux/include/asm/keyboard.h:25: warning: `struct
> kbd_repeat' declared inside parameter list
> /home/donjr/linux/include/asm/keyboard.h:25: warning: its scope is only
> this definition or declaration, which is probably not what you want.
> gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -c -o defkeymap.o
> defkeymap.c
> gcc -D__KERNEL__ -I/home/donjr/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mno-fp-regs -ffixed-8 -mcpu=pca56 -Wa,-mev6    -c -o pc_keyb.o
> pc_keyb.c
[...]

Look at the #includes immediately following #ifdef __KERNEL__ in
include/asm-i386/keyboard.h, and copy them into
include/asm-alpha/keyboard.h.

	Jeff



