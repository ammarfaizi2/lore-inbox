Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQKUFtf>; Tue, 21 Nov 2000 00:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQKUFt0>; Tue, 21 Nov 2000 00:49:26 -0500
Received: from sp28fe.nerdc.ufl.edu ([128.227.128.108]:8715 "EHLO smtp.ufl.edu")
	by vger.kernel.org with ESMTP id <S129604AbQKUFtO>;
	Tue, 21 Nov 2000 00:49:14 -0500
From: rml@ufl.edu
To: <linux-kernel@vger.kernel.org>
Subject: [WEIRD] working kernel off RH7's gcc-2.96!?
Message-ID: <974783952.3a1a05d0c4840@webmail.ufl.edu>
Date: Tue, 21 Nov 2000 00:19:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i dont want to revisit the flame fest (at all, please) but it seems i have been
using a kernel that successfully compiled under RedHat 7's gcc snapshot (2.96). 
i normally use gcc-2.91.66 for everything (mv kgcc gcc) but just synced my
system with rawhide, so the gcc/kgcc pair is back on my system and i forgot. so
i recompiled to test11 yesterday, and:

[00:05:51]rml@phantasy:~# cat /proc/version 
Linux version 2.4.0-test11 (rml@phantasy) (gcc version 2.96 20000731 (Red Hat
Linux 7.0)) #1 Mon Nov 20 19:06:06 EST 2000

the odd thing is, not only did it compile, but my machine has been up for a day
with heavy use in X with a full-featured kernel! not only no OOPSs, but no bugs!

the only thing i thought of was that alan's kgcc detection routine was in-place,
and using the detected kgcc to compile but then doing a hardcoded use of "gcc"
to grab the version ... but i could not find the code by grepping.

so i went ahead and removed kgcc from my path and recompiled, and sure enough --
it compiled fine.

just fyi, but someone tell me i am on crack... regardless, i am about to reboot
into a gcc-2.91.66 kernel.

-- 
Robert M. Love
rml@tech9.net
rml@ufl.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
