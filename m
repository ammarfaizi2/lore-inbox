Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbTFYSln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTFYSlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:41:42 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:13787
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S264946AbTFYSlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:41:40 -0400
Subject: Re: AMD MP, SMP, Tyan 2466
From: Edward Tandi <ed@efix.biz>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200306251501.14207.jbriggs@briggsmedia.com>
References: <BB1F47F5.17533%kernel@mousebusiness.com>
	 <200306251501.14207.jbriggs@briggsmedia.com>
Content-Type: text/plain
Message-Id: <1056567378.31260.9.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jun 2003 19:56:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 20:01, joe briggs wrote:
> Forgot to mention - 
> I tried this board with PC2100 bought from the local computer store (don't 
> know the name) and I got all kinds of weird problems like boot failure, file 
> system corruption, everything except a memory error.  I then tried a 512 mb 
> stick of kingston pc2100 and it completely solved the problems.

Yes, for SMP mode you absolutely need to use 'registered' RAM. Normal
PC2100 ram will work OK with one processor but quickly fails with two (I
had the same problems). Apparently, DDR RAM uses one clock edge to
transfer in one direction and the opposite edge to transfer back again
so the registers do synchronisation between one processor writing to the
same location that the other one reads from. That's how it was explained
to me anyway.

Ed-T.

> On Wednesday 25 June 2003 01:37 pm, Artur Jasowicz wrote:
> > To make sure that I have a clean environment I've reinstalled RedHat 9
> > workstation. This is supposed to give a complete set of tools for software
> > development. It did not install kernel sources though, so I've installed
> > that RPM. It installed sources for 2.4.20.
> >
> > Then I've downloaded kernel 2.4.21 from vger. I placed the decompressed
> > source in /home/linux2.4.21/. I based my configuration on RedHat's config
> > for AMD SMP (included in kernel source RPM) and on
> > linux-2.4.21/arch/i386/defconfig. Recompiled the kernel.
> >
> > On first attempt to boot from that new kernel the machine started acting up
> > and eventually froze. I've tried rebooting from RedHat installed non-SMP
> > kernel a couple of times and kept getting stuck in various places during
> > the boot.
> >
> > I started suspecting the RAM. I replaced the Corsair PC2100 1GB module with
> > a 512M module. The machine started working fine under RedHat kernel.
> > Switched to my SMP kernel - it ran fine except for one time when it simply
> > logged me out while I was in the middle of typing a bash command.
> >
> > I've logged back in, recompiled Promise driver while running in SMP. This
> > was the first time I was able to do that in SMP. I've loaded the driver,
> > left machine running overnight. Came in this morning - machine was still
> > up. I attempted to copy some files to Promise Raid volume. The machine
> > locked up in the middle of transfer. I tried to reboot in SMP and it failed
> > each time. I rebooted with RedHat's 2.4.20-8smp kernel but with nosmp boot
> > parameter and it came up ok. Rebooted the same kernel without the nosmp
> > parameter and it did this...

