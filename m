Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266529AbRGTEBc>; Fri, 20 Jul 2001 00:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266531AbRGTEBV>; Fri, 20 Jul 2001 00:01:21 -0400
Received: from smtp2.ihug.co.nz ([203.109.252.8]:34572 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S266529AbRGTEBH>;
	Fri, 20 Jul 2001 00:01:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunix@ihug.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: MTD compiling error
Date: Fri, 20 Jul 2001 15:59:34 +1200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01072012460800.09910@kiwiunix.ihug.co.nz> <3B5789F0.60605E80@resilience.com>
In-Reply-To: <3B5789F0.60605E80@resilience.com>
MIME-Version: 1.0
Message-Id: <01072015593400.19180@kiwiunix.ihug.co.nz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

gcc -D__KERNEL__ -I/usr/src/linux-2.4.6/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o cfi_probe.o 
cfi_probe.c
In file included from cfi_probe.c:17:
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h: In function `cfi_spin_unlock':
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq' undeclared 
(first use in this function)
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: (Each undeclared identifier 
is reported only once
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: for each function it 
appears in.)
make[3]: *** [cfi_probe.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd/chips'
make[2]: *** [_modsubdir_chips] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd'
make[1]: *** [_modsubdir_mtd] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.6/drivers'
make: *** [_mod_drivers] Error 2
[root@kiwiunix linux]#

After adding #include <spinlock.h> in the CFI.h header file, the result was 
that there is a undeclared identifier. Since I don't know C (Only java, BBC 
Basic, and COBOL), I don't know how to correct the problem.

Matthew Gardiner

-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.
