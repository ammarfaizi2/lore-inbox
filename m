Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUHLUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUHLUTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHLUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:19:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30944 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268682AbUHLUTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:19:07 -0400
Date: Thu, 12 Aug 2004 16:04:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Charlie Brej <brejc8@vu.a.la>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducable user mode system hang
Message-ID: <20040812190444.GC23182@logos.cnet>
References: <411BC339.30504@vu.a.la>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BC339.30504@vu.a.la>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 08:21:29PM +0100, Charlie Brej wrote:
> I have seem to have found a method to hang the kernel from user mode. The 
> system hangs and does not print an Oops. It still responds to network pings 
> but nothing else.
> 
> I have successfully crashed the 2.6 kernels on three different machines 
> (all athlon 2.6 kernels):
> Linux rain.cs.man.ac.uk 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 
> athlon i386 GNU/Linux
> Linux solem.cs.man.ac.uk 2.6.6-1.374 #1 Wed May 19 12:44:14 EDT 2004 i686 
> athlon i386 GNU/Linux
> Linux hogshead 2.4.20-8 #1 Thu Mar 13 17:18:24 EST 2003 i686 athlon i386 
> GNU/Linux
> 
> This problem does not occur on any 2.4 kernel machines I have tried.
> 
> Reproducing the problem:
> 
> Unfortunately the problem occurs in the middle of a program execution and I 
> have been unable to track it down.
> 
> Download kmd 0.9.19pre1 from (If anyone wants I could distribute my 
> binarys):
> http://www.cs.man.ac.uk/~brejc8/kmd/dist/KMD-0.9.19.pre1.tar.gz
> In user mode configure, compile and execute from the source directory:
> "./kmd -e ./jimulator"
> In the memory windows in the address box type in "E1000000" and press 
> return.
> This should now crash the system.
> 
> Kmd sporns an emulator (jimulator) with which it communicates using 
> stdin/out pipes. I suspect it is a problem in the pipe communication. It 
> occurs even when run under valgrind. I don't know of many methods of 
> narrowing down the search.

Can you get any kind of trace (ctrl+sysrq+p or NMI oopser) ? 

And also make sure to rerun the tests with newer v2.6's. 
