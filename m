Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSFETue>; Wed, 5 Jun 2002 15:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFETud>; Wed, 5 Jun 2002 15:50:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4870 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316221AbSFETub>;
	Wed, 5 Jun 2002 15:50:31 -0400
Message-ID: <3CFE6B31.39EC2719@zip.com.au>
Date: Wed, 05 Jun 2002 12:49:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow mpage.c to build
In-Reply-To: <20020605160547.C10293@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Linus,
> 
> When trying to build mpage.c for ARM, I get errors from bio.h since kdev_t
> isn't defined.  The following fixes this.
> 
> (I fail to see how this can build for anyone as it currently stands; its
> probably something x86 specific buried in the asm-i386 includes.)
> 
> ...

/usr/src/25/include/linux/bio.h
 /usr/src/25/include/asm/io.h
  /usr/src/25/include/linux/vmalloc.h
   /usr/src/25/include/linux/mm.h
    /usr/src/25/include/linux/swap.h
     /usr/src/25/include/linux/kdev_t.h

Lovely, isn't it?

-
