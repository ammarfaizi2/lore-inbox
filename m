Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314462AbSDRV0L>; Thu, 18 Apr 2002 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314463AbSDRV0K>; Thu, 18 Apr 2002 17:26:10 -0400
Received: from air-2.osdl.org ([65.201.151.6]:2576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S314462AbSDRV0J>;
	Thu, 18 Apr 2002 17:26:09 -0400
Date: Thu, 18 Apr 2002 14:22:12 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: Gabor Kerenyi <wom@tateyama.hu>
Subject: Re: offtpic: GPL driver vs. non GPL driver
In-Reply-To: <E16xnL9-00022l-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L2.0204181410570.11734-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Alan Cox wrote:

| > First question: Is it possible to write the driver in GPL and then develop a
| > binary only LIB? (I think yes because the LIB is in user space)
|
| Thats a legal question about derivative works again. Its a lawyer question.
| Don't ask lawyers how to program, don't ask programmers how the law works 8)
|
| In business terms a binary only driver means that it won't be considered for
| the mainstream kernel and you will need to rebuild it for every exact kernel
| version your customers want. Irrespective of the GPL/lib question it may be
| helpful to provide your customers source code to the kernel part of the
| driver if only so you don't have to keep recompiling it. VMware follows very
| much this model - their kernel bits are source code, vmware itself is most
| definitely proprietary and per copy licensed.

Hi-

If this isn't clear to you, consider all of the processor-type
possibilities, CONFIG possibilities, etc., that you could need to
build for...not that anyone does all of this, but you could have
customers who want all of these variations.[1]

Furthermore, with open source code, you get lots of debugging
help and often get help porting the driver to newer kernel
versions (there's always something needed for the next kernel
version).

Another argument, if your company is concerned about exposing IP,
is that you expose IP that is not exactly the latest and greatest.
So what?  Maybe some other company will try to copy it.
If they do, they will be working on a design that is a generation
behind your company's new/latest design!


[1] from 2.4.18:
alpha/  cris/  ia64/  mips/    parisc/  s390/   sh/     sparc64/
arm/    i386/  m68k/  mips64/  ppc/     s390x/  sparc/

CONFIG_SMP=y or n requires a different kernel build.

CONFIG_HIGHMEM=z requires a different kernel build.

Not to mention CONFIG_module support, processor tuning...

(probably missed a few CONFIG options here...)

Now how many target kernel binaries do you want to build for
each kernel version?

15 processor_types * 2 * 2 = 60 kernel binaries per kernel version
(but obviously worst case since you won't support all of
those processor types)

-- 
~Randy

