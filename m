Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTJMQC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJMQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:02:26 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:2982 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S261806AbTJMQCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:02:23 -0400
Date: Mon, 13 Oct 2003 09:02:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031013160222.GG3634@ip68-0-152-218.tc.ph.cox.net>
References: <20030829184910.GB10336@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310100952010.11062-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310100952010.11062-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 12:20:56PM +0300, Meelis Roos wrote:
> > > 1. Network interface is detected correctly but first ifconfig command
> > > (even if it fails because of wrong arguments) hangs the machine. This is
> > > with both tulip driver (new io+mmio or mmio or just plain pio, 3 modes
> > > tried) and de4x5 driver (the card is a onboard 21140).
> > >
> > > 2. 2.4 detects full 64M of RAM, 2.6 detects only 32M of RAM.
> >
> > Interesting.  Can you try the linuxppc_2_4_devel
> > (http://penguinppc.org/dev/kernel.shtml) tree and let me know if that
> > finds 32mb or 64mb of RAM?
> 
> Yesterday I got the machine back from production use and tried to
> compile it. It did not compile for my configuration. I also tried
> 2.6.0-test6 that I had cheked out, it made no difference, still only 32M
> RAM and hang on ifconfig eth0 up.
> 
> make[2]: Entering directory `/home/mroos/compile/linuxppc_2_4_devel/arch/ppc/mm'
> gcc -D__KERNEL__ -I/home/mroos/compile/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/mroos/compile/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=init  -c -o init.o init.c
> init.c:47:22: mmu_decl.h: No such file or directory

That's not right.  Did you do a 'bk -r get -q' or equivalent?  Or is
this the rsync version?

> Here is my .config for linuxppc-2.4-devel:

Works for me.

-- 
Tom Rini
http://gate.crashing.org/~trini/
