Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbTCSUkS>; Wed, 19 Mar 2003 15:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263158AbTCSUkS>; Wed, 19 Mar 2003 15:40:18 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:54659 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S263142AbTCSUkR>;
	Wed, 19 Mar 2003 15:40:17 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: philippe.gramoulle@mmania.com, linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com>
	<8765qfacaz.fsf@lapper.ihatent.com>
	<20030319182442.4a9fa86c.philippe.gramoulle@mmania.com>
	<877kav5ikv.fsf@lapper.ihatent.com>
	<20030319121909.74f957af.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Mar 2003 21:51:17 +0100
In-Reply-To: <20030319121909.74f957af.akpm@digeo.com>
Message-ID: <87n0jr3wsa.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > I've had I/O stall a few times while watching movies, but only the
> > mplayer process hung, and I could break it off and restart and it
> > woudl fun again for a few minutes.
> 
> This is a bug in the new nanosleep code.  mplayer asks the kernel for a 50
> millisecond sleep and the kernel gives it a two month sleep instead.
> 
> Please set INITIAL_JIFFIES to zero and retest.
> 
> With what compiler are you building your kernels?
> 

>From Gentoo's unstable "branch":

alexh@lapper ~/src/linux/linux-2.5.65-mm2 $ gcc -v
Reading specs from /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/specs
Configured with: /var/tmp/portage/gcc-3.2.2-r1/work/gcc-3.2.2/configure --prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.2 --includedir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2 --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/man --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.2/info --enable-shared --host=i686-pc-linux-gnu --target=i686-pc-linux-gnu
--with-system-zlib --enable-languages=c,c++,ada,f77,objc,java --enable-threads=posix --enable-long-long --disable-checking --enable-cstdio=stdio --enable-clocale=generic --enable-__cxa_atexit --enable-version-specific-runtime-libs --with-gxx-include-dir=/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2.2/include/g++-v3 --with-local-prefix=/usr/local --enable-shared --enable-nls --without-included-gettext
Thread model: posix
gcc version 3.2.2
alexh@lapper ~/src/linux/linux-2.5.65-mm2 $ ld -v
GNU ld version 2.13.90.0.18 20030206
alexh@lapper ~/src/linux/linux-2.5.65-mm2 $

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
