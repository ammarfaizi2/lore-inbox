Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRCKBiH>; Sat, 10 Mar 2001 20:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131187AbRCKBh6>; Sat, 10 Mar 2001 20:37:58 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:52239 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131184AbRCKBhr>; Sat, 10 Mar 2001 20:37:47 -0500
Message-ID: <3AAAD694.B0482AE8@leo.org>
Date: Sun, 11 Mar 2001 02:36:20 +0100
From: Joachim Herb <herb@leo.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compilation error in 2.4.3-pre3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get the following compilation error:
gcc -D__KERNEL__ -I/tmp2/src/linux-2.4.3.jh/include -Wall
-Wstrict-prototypes -O
2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -
march=i686 -malign-functions=4     -c -o proc_misc.o proc_misc.c
proc_misc.c: In function `read_profile':
proc_misc.c:452: `prof_shift' undeclared (first use in this function)
proc_misc.c:452: (Each undeclared identifier is reported only once
proc_misc.c:452: for each function it appears in.)
proc_misc.c:454: `prof_len' undeclared (first use in this function)
proc_misc.c:464: `prof_buffer' undeclared (first use in this function)
proc_misc.c: In function `write_profile':
proc_misc.c:494: `prof_len' undeclared (first use in this function)
proc_misc.c:494: `prof_buffer' undeclared (first use in this function)
proc_misc.c: In function `proc_misc_init':
proc_misc.c:563: `prof_shift' undeclared (first use in this function)
proc_misc.c:567: `prof_len' undeclared (first use in this function)
make[3]: *** [proc_misc.o] Error 1
make[3]: Leaving directory `/tmp2/src/linux-2.4.3.jh/fs/proc'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/tmp2/src/linux-2.4.3.jh/fs/proc'
make[1]: *** [_subdir_proc] Error 2
make[1]: Leaving directory `/tmp2/src/linux-2.4.3.jh/fs'
make: *** [_dir_fs] Error 2

I use:
# gcc --version
2.95.3
(Mandrake 7.2)

This variables were defined in asm/string.h but now I can only find them
in asm/hw_irq.h. I have included asm/hw_irq.h and it compiles but I get
a warning:
make[3]: Entering directory `/tmp2/src/linux-2.4.3.jh/fs/proc'
gcc -D__KERNEL__ -I/tmp2/src/linux-2.4.3.jh/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     -c -o
proc_misc.o proc_misc.c
In file included from proc_misc.c:42:
/tmp2/src/linux-2.4.3.jh/include/asm/hw_irq.h:219: warning: `struct
hw_interrupt_type' declared inside parameter list
/tmp2/src/linux-2.4.3.jh/include/asm/hw_irq.h:219: warning: its scope is
only this definition or declaration, which is probably not what you
want.
rm -f proc.o

Bye,
Joachim

P.S. Please send also an email to my private address as I am not
subscribed to the list.
-- 
Joachim Herb
mailto:herb@leo.org
