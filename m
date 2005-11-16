Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVKPSi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVKPSi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVKPSi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:38:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55823 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030429AbVKPSi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:38:28 -0500
Date: Wed, 16 Nov 2005 19:38:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116183828.GO5735@stusta.de>
References: <303ad3.6fa079@familynet-international.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303ad3.6fa079@familynet-international.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 02:03:50AM +0000, Kenneth Parrish wrote:
> -=> In article 15 Nov 05  15:00:28, Adrian Bunk wrote to All <=-
> 
> [...]
>  AB> Unconditionally enabling 4k stacks is the only way to achieve
>  AB> this.
> :) 2K might do here..

No, it wouldn't.

If one function calls another function you have to add the stack usages.

> 5 Tue Nov 15 19:29:43 ~/build/kernel/linux-2.6.15-rc1-git3 $ make checkstack
> objdump -d vmlinux $(find . -name '*.ko') | \
> perl /home/ken/build/kernel/linux-2.6.15-rc1-git3/scripts/checkstack.pl i386
> 0xc02bd528 huft_build:                                  1432
> 0xc02bd954 huft_build:                                  1432
> 0xc02be1c4 inflate_dynamic:                             1312
> 0xc02be2ff inflate_dynamic:                             1312
> 0xc02be082 inflate_fixed:                               1168
> 0xc02be172 inflate_fixed:                               1168
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

