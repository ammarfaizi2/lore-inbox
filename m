Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVB1NdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVB1NdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVB1NdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:33:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20241 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261589AbVB1Nc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:32:57 -0500
Date: Mon, 28 Feb 2005 14:32:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: colbuse@ensisun.imag.fr
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code
Message-ID: <20050228133253.GC4021@stusta.de>
References: <1109596437.422319158044b@webmail.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109596437.422319158044b@webmail.imag.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 02:13:57PM +0100, colbuse@ensisun.imag.fr wrote:
> 
> >On Mon, Feb 28, 2005 at 01:57:59PM +0100, colbuse@xxxxxxxxxxxxxxx wrote:
> >> Please _don't_ apply this, but tell me what you think about it.
> 
> >It's broken. 8)
> 
> >> --- old/drivers/char/vt.c 2004-12-24 22:35:25.000000000 +0100
> >> +++ new/drivers/char/vt.c 2005-02-28 12:53:57.933256631 +0100
> >> @@ -1655,9 +1655,9 @@
> >> vc_state = ESnormal;
> >> return;
> >> case ESsquare:
> >> - for(npar = 0 ; npar < NPAR ; npar++)
> >> + for(npar = NPAR-1; npar < NPAR; npar--)
> 
> >How many times do you want this for loop to run?
> 
> 
> NPAR times :-). As I stated, npar is unsigned.
>...

The Linux kernel is not the obfuscated C contest.

Your code might be technically correct, but your patch changes a 
perfectly readable line into an unreadable line for no gain.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

