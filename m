Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbQKUTho>; Tue, 21 Nov 2000 14:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129872AbQKUThe>; Tue, 21 Nov 2000 14:37:34 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:30732 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129682AbQKUThQ>; Tue, 21 Nov 2000 14:37:16 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 21 Nov 2000 12:07:10 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
MIME-Version: 1.0
Message-Id: <00112112071001.00924@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.4.0-test11-ac1, and here is where the compile bombed out:

/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o 
sched.o sched.c
irq.c:182: conflicting types for `global_irq_lock'
/usr/src/linux/include/asm/hardirq.h:45: previous declaration of 
`global_irq_lock'
make[1]: *** [irq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-ac1/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

Some additional information:

[root@spc linux]# which kgcc
/usr/bin/kgcc
[root@spc linux]# kgcc --version
egcs-2.91.66
[root@spc linux]# which make
/usr/bin/make
[root@spc linux]# make --version
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
Built for i586-mandrake-linux-gnu

I also had the reiserfs-3.6.19 patch applied, but the compile made it through
the reiserfs part successfully.  This all works just fine with 2.4.0-test11, 
where I used gcc 2.95.3 as supplied by Linux-Mandrake 7.2.

Steven
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
