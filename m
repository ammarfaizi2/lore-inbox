Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTKUPsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 10:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTKUPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 10:48:06 -0500
Received: from ns.sws.net.au ([61.95.69.3]:45580 "EHLO ns.sws.net.au")
	by vger.kernel.org with ESMTP id S262965AbTKUPsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 10:48:03 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Christian Kujau <evil@g-house.de>
Subject: Re: de2104x tulip driver bug in 2.6.0-test9
Date: Sat, 22 Nov 2003 02:47:49 +1100
User-Agent: KMail/1.5.4
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200311212051.32352.russell@coker.com.au> <3FBE2FF4.5010904@g-house.de>
In-Reply-To: <3FBE2FF4.5010904@g-house.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311220247.49948.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003 02:32, Christian Kujau <evil@g-house.de> wrote:
> Russell Coker wrote:
> > 00:14.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
> > [Tulip Pass 3] (rev 11)
> >
> > Above is the lspci output for my PCI Ethernet card.  Below is what
> > happens when I try to boot 2.6.0-test9.  2.4.x kernels have been working
> > well on the same card for a long time, so the hardware seems basically
> > OK.
> >
> > Configuring network interfaces... eth0: set link BNC
> >  eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef09,0xfffff7fd,0xffff0006
> >  eth0:    set mode 0x7ffc0000, set sia 0xef09,0xf7fd,0x6
> >  eth0: timeout expired stopping DMA
>
> could this be anyhow related to this:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106766135110165&w=2
>
> there is a thread on linuxppc-dev too, as this is ppc specific:

It is a bit different.  If I don't load the module during the boot sequence 
then I can get it to the stage of being pingable.  I think that timing is the 
issue, the boot scripts do everything quickly.  If I modprobe it, then 
ifconfig it, then change the media type, then I have succeeded once in 
getting ping responses, but I couldn't ssh.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

