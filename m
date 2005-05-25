Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEYROz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEYROz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVEYROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:14:55 -0400
Received: from mail.tyan.com ([66.122.195.4]:46096 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261482AbVEYROn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:14:43 -0400
Message-ID: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Tech Support <TechSupport@tyan.com>,
       support@tyan.de, Andrew Morton <akpm@osdl.org>, gl@fenedex.nl,
       land@hetlageland.nl, hans@sww.nl, sww@sww.nl
Subject: RE: Tyan Opteron boards and problems with parallel ports
Date: Wed, 25 May 2005 10:15:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't always blame BIOS, if you like you could use LinuxBIOS instead....

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Wednesday, May 25, 2005 9:50 AM
> To: Linus Torvalds
> Cc: linux-kernel@vger.kernel.org; Tech Support; 
> support@tyan.de; Andrew Morton; gl@fenedex.nl; 
> land@hetlageland.nl; hans@sww.nl; sww@sww.nl
> Subject: Re: Tyan Opteron boards and problems with parallel ports
> 
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 20 May 2005, Robert M. Stockmann wrote:
> >> 
> >> All problems of Tyan Opteron based machines silently locking up 
> >> during installation and/or during normal operation of 
> running Linux, 
> >> both 32bit and 64bit, without any display of kernel panic of any 
> >> other logging method, seem to be solved when switching off the 
> >> Parallel Port inside its BIOS.
> 
> The common Tyan problem case is when the machine has more 
> than 3GB of RAM and "memory remapping" is enabled to recover 
> the memory below the PCI memory hole. SOmething in that setup 
> leads to problems and random memory corruption. I suspect a 
> BIOS bug here.
> 
> Workaround is to not enable that option in the BIOS setup.
> 
> Then another older Tyan board (it might have been the K8W) 
> was *extremly* picky in what DIMMs it accepted and in what 
> slots because someone apparently didnt follow the AMD 
> specification for the memory controller trace lines fully. 
> That also caused common problems. 
> 
> 
> > Can you do an install with the thing turned off, and then
> >  - compile the kernel with CONFIG_PCI_DEBUG
> >  - boot with the parallel port enabled, and send as much of 
> the bootup 
> >    output (and /proc/iomem and /proc/ioport) as possible
> >  - boot with the parallel port disabled, and send the same 
> output for that 
> >    working case.
> >
> > I have no clue why the parallel port should matter, but it could 
> > change some resource allocation issues.
> 
> It is the first time I heard about such a issue so it cannot 
> be too wide spread anyways. 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
