Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTLEQeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLEQeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:34:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:23265 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264151AbTLEQeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:34:02 -0500
Date: Fri, 5 Dec 2003 13:52:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Meelis Roos <mroos@linux.ee>, <linux-kernel@vger.kernel.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
In-Reply-To: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt?

On Thu, 4 Dec 2003, Anton Altaparmakov wrote:

> Marcelo,
> 
> 2.4.23-bk has a changeset (post 2.4.23 release TAG) that makes edd not
> compile as Meelis Roos already reported:
> 
> On Thu, 4 Dec 2003, Meelis Roos wrote:
> > gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup  -DEXPORT_SYMTAB -c setup.c
> > setup.c: In function `copy_edd':
> > setup.c:734: error: `DISKSIG_BUFFER' undeclared (first use in this function)
> > setup.c:734: error: (Each undeclared identifier is reported only once
> > setup.c:734: error: for each function it appears in.)
> > make[1]: *** [setup.o] Error 1
> >
> > DISKSIG_BUFFER is nowhere to be seen.
> 
> Further, looking at the header files the closest constant that does exist
> is #define DISK80_SIG_BUFFER 0x228 from include/asm-i386/edd.h.
> 
> However, changing DISKSIG_BUFFER to DISK80_SIG_BUFFER causes the kernel to
> reboot the computer as soon as it starts booting.  Basically I select it
> in grub and the screen changes graphics mode and by the time it has
> finished the switch the computer reboots.
> 
> 2.4.23-bk at the 2.4.23 release TAG works fine and compiles fine with the
> same .config.
> 
> Best regards,
> 
> 	Anton
> 


