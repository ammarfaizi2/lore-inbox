Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262319AbSI3QWK>; Mon, 30 Sep 2002 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSI3QWJ>; Mon, 30 Sep 2002 12:22:09 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:57583 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262319AbSI3QWF>; Mon, 30 Sep 2002 12:22:05 -0400
Subject: Re: CPU/cache detection wrong
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3hegaxpp0.fsf@lapper.ihatent.com>
References: <m3hegaxpp0.fsf@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 17:34:15 +0100
Message-Id: <1033403655.16933.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 13:29, Alexander Hoogerhuis wrote:
> CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.70GHz stepping 04
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> 
> The machine is a Comapq Evo n800c with a 1.7GHz P4-M in it, and
> according to the BIOS I've got 16kb/512Kb L1/L2-cache. Accroding to
> the 2.4.20-pre7-ac3-kernel. It's been like this at least since
> 2.4.19-pre4 or so.

Can you stick a printk in arch/i386/kernel/setup.c in the function
init_intel    

Just before:                         
        /* look up this descriptor in the table */

stick

        printk("Cache info byte: %02X\n", des);

that will dump the cache info out of the CPU as the kernel scans it and
should let us find the error in the table.


