Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSI3RiM>; Mon, 30 Sep 2002 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSI3RiM>; Mon, 30 Sep 2002 13:38:12 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:42216 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262452AbSI3RiL>;
	Mon, 30 Sep 2002 13:38:11 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
References: <m3hegaxpp0.fsf@lapper.ihatent.com>
	<1033403655.16933.20.camel@irongate.swansea.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 30 Sep 2002 19:43:16 +0200
In-Reply-To: <1033403655.16933.20.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3wup3bcgb.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sat, 2002-09-28 at 13:29, Alexander Hoogerhuis wrote:
> > CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > 
> > The machine is a Comapq Evo n800c with a 1.7GHz P4-M in it, and
> > according to the BIOS I've got 16kb/512Kb L1/L2-cache. Accroding to
> > the 2.4.20-pre7-ac3-kernel. It's been like this at least since
> > 2.4.19-pre4 or so.
> 
> Can you stick a printk in arch/i386/kernel/setup.c in the function
> init_intel    
> 
> Just before:                         
>         /* look up this descriptor in the table */
> 
> stick
> 
>         printk("Cache info byte: %02X\n", des);
> 
> that will dump the cache info out of the CPU as the kernel scans it and
> should let us find the error in the table.
> 

And the jury says:

PU: Before vendor init, caps: 3febf9ff 00000000 00000000, vendor = 0
Cache info byte: 50
Cache info byte: 5B
Cache info byte: 66
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 00
Cache info byte: 40
Cache info byte: 70
Cache info byte: 7B
Cache info byte: 00
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 3febf9ff 00000000 00000000 00000000

Let me know if you need more info :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
