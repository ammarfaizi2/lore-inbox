Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSEJJBq>; Fri, 10 May 2002 05:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSEJJBp>; Fri, 10 May 2002 05:01:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313190AbSEJJBp>;
	Fri, 10 May 2002 05:01:45 -0400
Message-ID: <3CDB8D2E.438E99C3@zip.com.au>
Date: Fri, 10 May 2002 02:04:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <3CDB4711.1A4FFDAC@zip.com.au> <5.1.0.14.2.20020510093714.01fa9680@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> ...
> >This code:
> >
> >         printk("%lu%s", some_sector, some_string);
> >
> >will work fine with 32-bit sector_t.  But with 64-bit sector_t it
> >will generate a warning at compile-time and an oops at runtime.
> >
> >The same problem applies to dma_addr_t.  Jeff, davem and I kicked
> >that around a while back and ended up deciding that although there
> >are a number of high-tech solutions, the dumb one was best:
> 
> Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu and
> typecast (unsigned long long)sector_t_variable in the printk.
> 

Agree.   The nice thing about the typecast is that you
can format the output with %06Lx, %9Ld, %Lo or whatever.
The FMT_SECTOR_T thing forces you to use the chosen formatting.

-
