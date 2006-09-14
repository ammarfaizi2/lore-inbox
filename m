Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWINRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWINRBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWINRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:01:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:5280 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWINRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:01:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JixAEBJAJaPJ/eD5B7V7/WxWW1s3cpvSN9be/DLn2yHYz1RvnoKyA1G2MVheRGlhr4/y5ZXh0PegLliN2tVwbB8C0ymtQzGVEgI/mfK910KraKeWHVvbUFuBXa2PyStEGuUrZZq0nGJelxrfr+1LlkL3q3FUSnOOYVLKHWgEIZs=
Message-ID: <6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com>
Date: Thu, 14 Sep 2006 19:01:38 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
	 <20060913015850.GB3034@melbourne.sgi.com>
	 <20060913042627.GE3024@melbourne.sgi.com>
	 <6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com>
	 <20060914035904.GF3034@melbourne.sgi.com> <450914C4.2080607@gmail.com>
	 <6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com>
	 <20060914090808.GS3024@melbourne.sgi.com>
	 <6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com>
	 <6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 14/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 14/09/06, David Chinner <dgc@sgi.com> wrote:
> > >
> > > What arch are you running on and what compiler are you using?
> >
> > gcc -v
> > Using built-in specs.
> > Target: i386-redhat-linux
> > Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
> > --infodir=/usr/share/info --enable-shared --enable-threads=posix
> > --enable-checking=release --with-system-zlib --enable-__cxa_atexit
> > --disable-libunwind-exceptions --enable-libgcj-multifile
> > --enable-languages=c,c++,objc,obj-c++,java,fortran,ada
> > --enable-java-awt=gtk --disable-dssi
> > --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
> > --with-cpu=generic --host=i386-redhat-linux
> > Thread model: posix
> > gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
> >
> > I'll build system with gcc 3.4
>
> It's not a compiler issue.
>
> Binary search should solve this mystery.

I was wrong - it's in vanilla tree
(http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1).

cat hunt | head -n 3
origin.patch
BAD
libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch

I can reproduce this bug with all CONFIG_DEBUG_*=y.
(only
CONFIG_DEBUG_SYNCHRO_TEST=m
CONFIG_RCU_TORTURE_TEST=m
as modules)

I have checked memory
http://www.stardust.webpages.pl/files/crap/memtest.jpg and everything
seems to be fine.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
