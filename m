Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUFUPfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUFUPfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266280AbUFUPfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:35:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:11963 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266273AbUFUPf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:35:28 -0400
Date: Mon, 21 Jun 2004 08:29:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rob Landley <rob@landley.net>
Cc: jgarzik@pobox.com, spam99@2thebatcave.com, linux-kernel@vger.kernel.org
Subject: Re: Using kernel headers that are not for the running kernel
Message-Id: <20040621082959.237645e7.rddunlap@osdl.org>
In-Reply-To: <200406201937.20057.rob@landley.net>
References: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
	<200406190546.50166.rob@landley.net>
	<20040620162405.GA16038@havoc.gtf.org>
	<200406201937.20057.rob@landley.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004 19:37:20 -0500 Rob Landley wrote:

| On Sunday 20 June 2004 11:24, Jeff Garzik wrote:
| 
| > Kernel-internal headers and definitions should absolutely never be used
| > in userspace.
| 
| Hence the old #ifdef KERNEL stuff, or whatever the guard was...
| 
| My only confusion was that when the #ifdefs stopped being maintained (written 
| off as inherently unworkable because people just #defined KERNEL when they 
| shouldn't), no actual replacement was pursued.  Instead the attitude seemed 
| to be "this is glibc's problem", we're too busy trying to get 2.6 out to 
| actually worry about anybody using it.  And calling it glibc's problem 
| doesn't work for me, because want to use uclibc...
| 
| > H. Peter Anvin has suggested an include/abi which could be shared, and
| > this seem quite reasonable to me.  However, the monumental task of
| > separating kernel-internal definitions from ABI definitions still
| > remains.
| >
| > 	Jeff, really glad the linux-libc-headers guys started his effort
| 
| Mazur seems to be doing a really nice job of it so far.  I'm building a small 
| distro based on it and sending him bug reports when I can't get something to 
| compile.  I'm happy to use his work, but I'd rather it got integrated into 
| the kernel.
| 
| Now that it's mostly stabilized, it seems that the remaining work is mostly 
| auditing, integrating it in under the include/abi directory, and cleaning up 
| the normal kernel headers to include the abi stuff rather than defining their 
| own copies in the kernel internal headers.
| 
| If an abi directory was created, I'd be happy to submit a file or two at a 
| time into it (with the corresponding patches to remove the definitions from 
| the main include directory and #include abi/whatever instead...)
| 
| (Is there some effort _other_ than Mazur's work I should know about?  Or 
| something wrong with Mazur's cleanups?  Or somebody already doing this...?)

Yes, or sort of.  There's a linuxabi mailing list:

http://zytor.com/mailman/listinfo/linuxabi

and talk about doing a big push on this in early 2.7.
There are several interested parties, but I don't know how interested
the top-level maintainer is in accepting such patches.


--
~Randy
