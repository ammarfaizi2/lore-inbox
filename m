Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279583AbRKATLD>; Thu, 1 Nov 2001 14:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279591AbRKATKx>; Thu, 1 Nov 2001 14:10:53 -0500
Received: from air-1.osdl.org ([65.201.151.5]:31237 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279583AbRKATKh>;
	Thu, 1 Nov 2001 14:10:37 -0500
Subject: Re: OSDL Scalable Test Platform test for linux_2_4_13
From: "Timothy D. Witham" <wookie@osdl.org>
To: Dmitry Volkoff <vdb@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011101065107.A23409@localhost>
In-Reply-To: <20011101065107.A23409@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 01 Nov 2001 11:11:22 -0800
Message-Id: <1004641889.3339.28.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  A couple of items explain these differences. The 1st is that 
UnixBench is a single stream number and is almost 100% cached even
with a smaller (128KB) cache. Also the benchmark uses a very small
amount of memory. This means that for any given version
of the compiler and OS the best absolute performance number will
be produced by the machine with the fastest single CPU. And
you won't see any improvement from adding additional CPUS.

  So what you are seeing is the difference between a single CPU
running at 866MHz on the 2 way and a single CPU running at
700 MHz on the 4 way. And of course your 1.4GHz would give better
numbers as you are looking at 700Mhz, 866MHz and then 1.4 GHz and
so the numbers should be 

  The idea behind this test setup isn't to compare machine x
verses machine y. (That's what marketing departments do.)
But to be able to compare the same hardware against its self
before and after a kernel change. 

wookie
   
On Wed, 2001-10-31 at 19:51, Dmitry Volkoff wrote:
> > These tests were performed against 2, 4, and 8 CPU 
> > IA-32 (Intel) servers. 
> 
> UnixBench results are somewhat funny. 
> 4-CPU machine is slower than the one with 2 CPU (238.4 vs 260.0)?
> Well, on UP Athlon 1.4Ghz with only 512 Mb RAM I get 460...
> 
> -- 
> 
>     DV
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)


