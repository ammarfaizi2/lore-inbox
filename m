Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTADMT3>; Sat, 4 Jan 2003 07:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbTADMT3>; Sat, 4 Jan 2003 07:19:29 -0500
Received: from daimi.au.dk ([130.225.16.1]:27882 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S266795AbTADMT2>;
	Sat, 4 Jan 2003 07:19:28 -0500
Message-ID: <3E16D347.D7C7C4B6@daimi.au.dk>
Date: Sat, 04 Jan 2003 13:27:51 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.54
References: <20030104114717.4116.qmail@linuxmail.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> From: Kasper Dupont <kasperd@daimi.au.dk>
> [...]
> > > arch/i386/kernel/vm86.c:289: structure has no member named `saved_gs'
> > > make[1]: *** [arch/i386/kernel/vm86.o] Error 1
> > > make: *** [arch/i386/kernel] Error 2
> >
> > Doesn't happen to me. Maybe I can reproduce it if I get a copy of
> > your .config file. And BTW, which gcc version are you using?
> 
> [root@frodo linux-2.5.53]# gcc -v
> Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.2/specs
> Configured with: ../configure --prefix=/usr --libdir=/usr/lib --with-slibdir=/lib --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --enable-long-long --enable-__cxa_atexit --enable-languages=c,c++,ada,f77,objc,java --host=i586-mandrake-linux-gnu --with-system-zlib
> Thread model: posix
> gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)

I'm using a different compiler version. That might be related to
the problem:

[kasperd:pts/0:/mnt/misc/kasperd/test/linux-2.5.54] gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
[kasperd:pts/0:/mnt/misc/kasperd/test/linux-2.5.54] 

> 
> And here it goes my .config.

The FB_I810 option was missing, but if I just set that one to no
I could compile without problems using your .config file.

How many versions do you have to go backwards to find a kernel
you can compile?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
