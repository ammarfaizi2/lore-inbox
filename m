Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131873AbQKJW42>; Fri, 10 Nov 2000 17:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132044AbQKJW4T>; Fri, 10 Nov 2000 17:56:19 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:11707 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131873AbQKJW4B>;
	Fri, 10 Nov 2000 17:56:01 -0500
Date: Fri, 10 Nov 2000 17:55:59 -0500
From: John Jasen <jjasen1@umbc.edu>
To: linux-kernel@vger.kernel.org
Subject: compiling md/lvm on 2.4.0-test9-test11-pre2 for alpha
Message-ID: <Pine.SGI.4.21L.01.0011101747510.502569-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've tried this on -test9, test10, and test11-pre2, all with similar
results.

I've checked the kernel mailing list archives, and didn't see anything
pertinent.

I'm getting the following errors: (in this case, attempting to make them
as a module)

<snip>
make -C md modules
make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre2/drivers/md'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11-pre2/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c 
xor.c
xor.c: In function `xor_block_alpha':
xor.c:1791: inconsistent operand constraints in an `asm'
xor.c: In function `xor_block_alpha_prefetch':
xor.c:2213: inconsistent operand constraints in an `asm'
make[2]: *** [xor.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.0-test11-pre2/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-pre2/drivers'
make: *** [_mod_drivers] Error 2
</snip>

This is running Redhat 6.2, with updates, compiling 2.4.0-test11-pre2,
with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release).

Any suggestions?

--
-- John E. Jasen (jjasen1@umbc.edu)
-- You can have it: right; cheap; now. Pick any two.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
