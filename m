Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTIKKRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 06:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbTIKKRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 06:17:12 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:17816 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S261199AbTIKKRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 06:17:09 -0400
Date: Thu, 11 Sep 2003 11:17:04 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911101704.GA24978@malvern.uk.w2k.superh.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910210416.GA24258@mail.jlokier.co.uk>
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 11 Sep 2003 10:17:53.0522 (UTC) FILETIME=[F6388520:01C3784D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

Thanks for posting the summary of your experiment - very useful!

* Jamie Lokier <jamie@shareable.org> [2003-09-10]:
> 
> Validity of SHMLBA value
> ........................
> 
> Many CPUs offer virtual cache coherency when the aliases are separated
> by a certain CPU-dependent multiple.  In principle, all
> Linux-supported architectures _should_ have a multiple which makes
> virtual aliases coherent, because it's defined in the API as "SHMLBA".
> However, on some specific CPUs, no coherent multiple was found.
> 
>     Valid kernel SHMLBA:	Sparc, PA-RISC, MIPS
> 				(plus all the coherent architectures)
>     SHMLBA not valid:		ARM, m68k
>     SHMLBA not defined:		SH

What's the basis for deciding wheter SHMLBA is defined or not? There are
definitions of SHMLBA in include/asm-sh/shmparam.h and
include/asm-sh64/shmparam.h for the kernel.  The sh64 /usr/include/asm
headers have effectively the same thing (not identical because the copy
I'm looking at hasn't been synced with the latest kernel sources), and I
assume the sh userland is OK too (haven't checked though).

In both cases the kernel headers are showing correct and useful values :
16k for SH-4 in the sh file (16k direct-mapped, or 32k 2-way associative
on latest devices), 8k for SH-5 in the sh64 file (32k 4-way
associative).

Cheers
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
