Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRA0PGT>; Sat, 27 Jan 2001 10:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131456AbRA0PGA>; Sat, 27 Jan 2001 10:06:00 -0500
Received: from wh3013.stw.uni-rostock.de ([139.30.103.13]:59312 "HELO
	proxy.home.camaya.de") by vger.kernel.org with SMTP
	id <S131341AbRA0PFr>; Sat, 27 Jan 2001 10:05:47 -0500
Date: Sat, 27 Jan 2001 16:05:27 +0100
From: Jakob Schroeter <js@camaya.de>
X-Priority: 3 (Normal)
Message-ID: <11215119686.20010127160527@camaya.de>
To: linux-kernel@vger.kernel.org
Subject: Re: "no such 386 instruction" with gcc 2.95.2
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu>
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a similar problem when compiling recent 2.4.0-ac or 2.4.1-pre kernels:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o i387.o i387.c
{standard input}: Assembler messages:
{standard input}:30: Error: no such 386 instruction: `ldmxcsr'
{standard input}:52: Error: no such 386 instruction: `fxsave'
{standard input}:87: Error: no such 386 instruction: `fxsave'
{standard input}:115: Error: no such 386 instruction: `fxrstor'
make[1]: *** [i387.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0-ac11/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

I'm using binutils 2.10.1 and egcs 1.1.2.

What could be the problem?

Thanks in advance,
                    Jakob


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
