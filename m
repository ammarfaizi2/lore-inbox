Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTIHISa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTIHIS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:18:29 -0400
Received: from users.linvision.com ([62.58.92.114]:15285 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262081AbTIHISY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:18:24 -0400
Date: Mon, 8 Sep 2003 10:17:15 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <jamie@shareable.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       bunk@fs.tum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       robert@schwebel.de, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030908101714.A25308@bitwizard.nl>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 07:09:49PM +0100, Alan Cox wrote:
> On Sul, 2003-09-07 at 18:43, Jamie Lokier wrote:
> > 	2. The CPU types are not a total order.  Say I want a kernel
> > 	   that supports Athlons and a Centaur for my cluster.  What
> > 	   CPU setting should I use?  What CPU setting will give my the best
> > 	   performing kernel - and is that the same as the one for smallest
> > 	   kernel?
> 
> You'd use two kernels. There is no sane other answer to that specific
> case 8)

Ehmm. In some cases, having multiple kernels is a pain in the @55. 

Having the option to make a generic kernel should remain. One that
works on as much as possible CPUs. Even if it's a bit suboptimal on
some CPUs. 

Also it would be nice if we can make the boot code run on anything
until the point where the CPU is detected. Then we can give a nice
message that the kernel was not compiled for this cpu instead of a 
blank-screen-hang. If we have to compile printk for 386 for this
then so be it. If your printk becomes 20 or 40% slower, then so be
it. If printk is critical to your kernel performance, then youve
got a problem anyway.... 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
