Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTIHMiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTIHMiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:38:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:26498 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262217AbTIHMiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:38:51 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Jamie Lokier <jamie@shareable.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       bunk@fs.tum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       robert@schwebel.de, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20030908101714.A25308@bitwizard.nl>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se>
	 <20030907174341.GA21260@mail.jlokier.co.uk>
	 <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
	 <20030908101714.A25308@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063024594.21050.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Mon, 08 Sep 2003 13:36:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 09:17, Rogier Wolff wrote:
> > You'd use two kernels. There is no sane other answer to that specific
> > case 8)
> 
> Ehmm. In some cases, having multiple kernels is a pain in the @55. 

Right but for the winchip its 10-30% difference in performance the
others are the odd %age point (except 386)

> Also it would be nice if we can make the boot code run on anything
> until the point where the CPU is detected.

Thats hard because we run a lot of the kernel before that point. So 
you'd want to write the asm checks for it in boot.S really, or export
CPU flag lists and model data and make the boot loader able to do so,
that also means grub can be taught to boot the best kernel of a set and
handle stuff itself

