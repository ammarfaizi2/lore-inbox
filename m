Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQLJUUk>; Sun, 10 Dec 2000 15:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbQLJUUa>; Sun, 10 Dec 2000 15:20:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:20484 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S130155AbQLJUUS>;
	Sun, 10 Dec 2000 15:20:18 -0500
Date: Sun, 10 Dec 2000 14:49:48 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: Compile Failure: mga_dma.o on 2.4.0-test12-pre8
Message-ID: <Pine.LNX.4.30.0012101445010.15992-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanly patched 2.4.0-test12-pre8 (with the correct pre8, linus!) ...
fails compile with the following. I have CONFIG_DRM_MGA enabled. pre7
compiled fine.

kgcc -D__KERNEL__ -I/home/rml/src/linux/linux/include -Wall
 -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
 -march=i686    -c -o mga_dma.o mga_dma.c
mga_dma.c: In function `mga_irq_install':
mga_dma.c:821: structure has no member named `next'
make[4]: *** [mga_dma.o] Error 1
make[4]: Leaving directory `/home/rml/src/linux/linux/drivers/char/drm'
make[3]: *** [first_rule] Error 2

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
