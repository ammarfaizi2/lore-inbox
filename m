Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUA0F5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUA0F5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:57:55 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:7833 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S262353AbUA0F5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:57:53 -0500
From: Eric <eric@cisu.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Date: Mon, 26 Jan 2004 23:57:07 -0600
User-Agent: KMail/1.5.94
Cc: stoffel@lucent.com, ak@muc.de, Valdis.Kletnieks@vt.edu, bunk@fs.tum.de,
       cova@ferrara.linux.it, linux-kernel@vger.kernel.org
References: <200401232253.08552.eric@cisu.net> <200401262343.35633.eric@cisu.net> <20040126215056.4e891086.akpm@osdl.org>
In-Reply-To: <20040126215056.4e891086.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401262357.07185.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 23:50, Andrew Morton wrote:
> Eric <eric@cisu.net> wrote:
> > YES. I finally have a working 2.6.2-rc1-mm3 booted kernel.
> >  Lets review folks---
> >  	reverted -funit-at-a-time
> >  	patched test_wp_bit so exception tables are sorted sooner
> >  	reverted md-partition patch
>
> The latter two are understood, but the `-funit-at-a-time' problem is not.
>
> Can you plesae confirm that restoring only -funit-at-a-time again produces
> a crashy kernel?  And that you are using a flavour of gcc-3.3?  If so, I
> guess we'll need to only enable it for gcc-3.4 and later.

Yea ill try it right now. Ill get back to you in about half hour, probably 
less. Would you like me to send you a complied kernel or some files that my 
compiler has generated if its still crashy?
	I remember reading somewhere on lkml about another problem that hung RIGHT on 
boot and it was related to GCC producing an invalid instruction for that 
particular processor. This smells of badly generated code. Heres a recap of 
my GCC:

SuSE Linux 8.2
eric:/usr/src/linux-2.6.2-rc1-mm3/linux-2.6.1 # gcc -v
Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.3/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.3 20030226 (prerelease) (SuSE Linux)


-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
