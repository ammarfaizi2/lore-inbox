Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVGSUX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVGSUX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVGSUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:23:27 -0400
Received: from tim.rpsys.net ([194.106.48.114]:50881 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261592AbVGSUWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:22:44 -0400
Subject: Re: Sharp Zaurus sl-5500 broken in 2.6.12
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: John Lenz <lenz@cs.wisc.edu>, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <20050719192104.GB32757@elf.ucw.cz>
References: <20050711193454.GA2210@elf.ucw.cz>
	 <33703.127.0.0.1.1121130438.squirrel@localhost>
	 <20050719180624.GB15186@atrey.karlin.mff.cuni.cz>
	 <20050719192104.GB32757@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 19 Jul 2005 21:22:31 +0100
Message-Id: <1121804551.7499.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 21:21 +0200, Pavel Machek wrote:
> Hi!
> 
> > ...and that's well known; but now I did some back tracking, and
> > 2.6.12-rc1 works, 2.6.12-rc2 does *not* and 2.6.12-rc2 with arm
> > changes reverted works. I'll play a bit more.
> 
> This fixes at least one break-the-boot bug in -rc2...
> 
> 							Pavel
> 
> --- linux-z11.rc2bad/arch/arm/mach-sa1100/collie.c	2005-07-19 20:49:07.000000000 +0200
> +++ linux-z11/arch/arm/mach-sa1100/collie.c	2005-07-19 21:05:54.000000000 +0200
> @@ -235,7 +235,7 @@
>  	sa11x0_set_flash_data(&collie_flash_data, collie_flash_resources,
>  			      ARRAY_SIZE(collie_flash_resources));
>  
> -	sharpsl_save_param();
> +//	sharpsl_save_param();
>  }
>  
>  static struct map_desc collie_io_desc[] __initdata = {

Could you check this wasn't caused by this typo please:

http://www.rpsys.net/openzaurus/patches/collie_typofix-r0.patch

(this has been fixed in recent kernels)

Cheers,

Richard

