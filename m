Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJJNVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJJNVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVJJNVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:21:37 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:15785 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVJJNVg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:21:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XucoZrygUSsptV1RR2OM8fLi5tVyjhSGSBG1gNqf6sxp8wG5Yrg8RUcBqU5hcCqDttT5zyYkSK+z5wv0vpXjtE1eUsikRJvNQxpxBVy3xrMGNA+pOVP612gmBmvf8mYvhEgqSBc6Yf31BnRrjLAJlfGD8m95694WktBc2DOpF00=
Message-ID: <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
Date: Mon, 10 Oct 2005 15:21:35 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Georg Lippold <georg.lippold@gmx.de>
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <434A6220.3000608@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
	 <20050831215757.GA10804@taniwha.stupidest.org>
	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>
	 <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>
	 <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Georg Lippold <georg.lippold@gmx.de> wrote:
> Hello Peter,
>
> my first post didn't get any attention, maybe it was too short.
> Here's a longer version:
>
> hpa@zytor.com wrote on Sept. 6th, 2005:
>
> [ wrt. COMMAND_LINE_SIZE=256 in linux/include/asm-i386/setup.h and
> linux/include/asm-i386/param.h ]
>
> >> I would like to push forward the idea to extend the command-line size...
> > [...]
> > Already pushed to Andrew.  I will follow it up with a patch to extend
> > the command line, at least to 512.
>
> I would like to know the status of this. In linux-2.6.14-rc3 the
> COMMAND_LINE_SIZE is still 256 chars long.
>
> Here's a patch to fix that to 1024.
>

What about the other archs ?

include/asm/setup.h:#define COMMAND_LINE_SIZE 256
include/asm/param.h:#define COMMAND_LINE_SIZE 256
include/asm-m68knommu/setup.h:#define COMMAND_LINE_SIZE 512
include/asm-powerpc/setup.h:#define COMMAND_LINE_SIZE   512
include/asm-sh/setup.h:#define COMMAND_LINE_SIZE 256
include/asm-um/setup.h:#define COMMAND_LINE_SIZE 4096
include/asm-parisc/setup.h:#define COMMAND_LINE_SIZE    1024
include/asm-x86_64/setup.h:#define COMMAND_LINE_SIZE    256
include/asm-xtensa/setup.h:#define COMMAND_LINE_SIZE    256
include/asm-alpha/setup.h:#define COMMAND_LINE_SIZE     256
include/asm-arm26/setup.h:#define COMMAND_LINE_SIZE 1024
include/asm-h8300/setup.h:#define COMMAND_LINE_SIZE     512
include/asm-sparc/setup.h:#define COMMAND_LINE_SIZE     256
include/asm-i386/setup.h:#define COMMAND_LINE_SIZE 256
include/asm-i386/param.h:#define COMMAND_LINE_SIZE 256
include/asm-cris/setup.h:#define COMMAND_LINE_SIZE      256
include/asm-m32r/setup.h:#define COMMAND_LINE_SIZE      (512)
include/asm-ia64/setup.h:#define COMMAND_LINE_SIZE      512
include/asm-m68k/setup.h:#define COMMAND_LINE_SIZE      CL_SIZE
include/asm-mips/setup.h:#define COMMAND_LINE_SIZE      256
include/asm-mips/bootinfo.h:#define CL_SIZE                    
COMMAND_LINE_SIZE
include/asm-s390/setup.h:#define COMMAND_LINE_SIZE      896
include/asm-v850/setup.h:#define COMMAND_LINE_SIZE      512
include/asm-sh64/setup.h:#define COMMAND_LINE_SIZE 256
include/asm-arm/setup.h:#define COMMAND_LINE_SIZE 1024
include/asm-frv/param.h:#define COMMAND_LINE_SIZE       512
include/asm-sparc64/setup.h:#define COMMAND_LINE_SIZE   256

Would it make sense to make it 1024 everywhere (and maybe move it out
of arch specific files and just set it in one central place) ?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
