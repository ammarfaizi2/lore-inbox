Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317681AbSFLKOJ>; Wed, 12 Jun 2002 06:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317683AbSFLKOI>; Wed, 12 Jun 2002 06:14:08 -0400
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:34756
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S317681AbSFLKOH>; Wed, 12 Jun 2002 06:14:07 -0400
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: cengiz@drtalus.aoe.vt.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <80256BD6.003883DF.00@notesmta.eur.3com.com>
Date: Wed, 12 Jun 2002 11:13:50 +0100
Subject: Re: 2.4.x kernels hang before uncompressing
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>   We have a Tri-M PC-104 system with a Cyrix ZF486 processor that (in
>addition to being painfully slow building kernels) refuses to boot any
>2.4.x kernels.
...
> It DOES appear to finish loading, because it outputs a linefeed after
>the line of dots in 'Loading linux....'

I experienced a similar problem with another National Geode board and traced the
problem back to the place where the kernel reads the BIOS memory map. I fixed it
by disabling the newer BIOS memory routines by adding '#define
STANDARD_MEMORY_BIOS_CALL' to linux/arch/i386/boot/setup.S. Alternatively try
adding it to the flags in linux/arch/boot/Makefile, since the compressed/misc.c
has similar #ifdef's.

If that fails try upgrading the BIOS or check out the ZFLinux web site
http://www.zfmicro.com/

     Jon Burgess


