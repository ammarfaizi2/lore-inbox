Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKRDGi>; Fri, 17 Nov 2000 22:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKRDG2>; Fri, 17 Nov 2000 22:06:28 -0500
Received: from jalon.able.es ([212.97.163.2]:54934 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129091AbQKRDGQ>;
	Fri, 17 Nov 2000 22:06:16 -0500
Date: Sat, 18 Nov 2000 03:36:09 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Errors in aa2
Message-ID: <20001118033609.C4381@werewolf.able.es>
Reply-To: jamagallon@able.es
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

When compiling Andreas aa2 patch I got:

/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-O4 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
-fno-strength-reduce -march=i686 -malign-loops=2 -malign-jumps=2
-malign-functions=2 -DCPU=686   -c -o time.o time.c
time.c: In function `do_gettimeofday':
time.c:727: fixed or forbidden register 0 (ax) was spilled for class AREG.
This may be due to a compiler bug or to impossible asm
statements or clauses.

The only difference is the inclusion of timeval_normalize.

If I get time.c from 2.2.18-pre21 compiles fine.
But I don't see any strange asm round there...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
