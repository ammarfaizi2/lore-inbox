Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262595AbUKXKcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbUKXKcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbUKXKcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:32:09 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:61319 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262595AbUKXKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:32:06 -0500
Date: Wed, 24 Nov 2004 11:21:51 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: hugang@soulinfo.com
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [PATH] swsusp update 3/3
Message-ID: <20041124102150.GC15009@bogon.ms20.nix>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041120003010.GG1594@elf.ucw.cz> <20041120081219.GA2866@hugang.soulinfo.com> <20041120224937.GA979@elf.ucw.cz> <20041122072215.GA13874@hugang.soulinfo.com> <20041122102612.GA1063@elf.ucw.cz> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <20041122165858.GC10609@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122165858.GC10609@hugang.soulinfo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 12:58:58AM +0800, hugang@soulinfo.com wrote:
> --- linux-2.6.9-ppc-g4-peval/drivers/video/aty/radeon_pm.c	2004-10-20 15:55:34.000000000 +0800
> +++ linux-2.6.9-ppc-g4-peval-hg/drivers/video/aty/radeon_pm.c	2004-11-22 17:16:58.000000000 +0800
> @@ -859,6 +859,10 @@
>  	 * know we'll be rebooted, ...
>  	 */
>  
> +#if 0	/* this breaks suspend to ram until the dust settles... */
> +	if (state != PM_SUSPEND_MEM)
> +#endif
> +		return 0;
>  	printk(KERN_DEBUG "radeonfb: suspending to state: %d...\n", state);
>  	
>  	acquire_console_sem();
Please don't. I only added this to my ppc swsusp patches as a temporary
hack. It should use "flags = SUSPEND_TO_RAM" from Pavel's bigdiff.
I submitted other parts to BenH a while ago, I'm currently working on
cleaning some parts up and make it work with suspend-to-ram.
 -- Guido
