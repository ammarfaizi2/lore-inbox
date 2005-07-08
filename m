Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVGHX3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVGHX3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVGHX06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:26:58 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38917 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262922AbVGHWR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:17:59 -0400
Date: Sat, 9 Jul 2005 00:17:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation mismatch in Documentation/kbuild/kconfig-language.txt
Message-ID: <20050708221756.GM3671@stusta.de>
References: <Pine.LNX.4.58.0507041639500.24224@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507041639500.24224@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 04:59:18PM +0200, Bodo Eggert wrote:
> --- Documentation/kbuild/kconfig-language.txt ---
> - input prompt: "prompt" <prompt> ["if" <expr>]
>   Every menu entry can have at most one prompt, which is used to display
>   to the user. Optionally dependencies only for this prompt can be added
>   with "if".
> ---
> 
> This is misleading, since the "if" will not affect only the prompt, but 
> also the config option. 
> 
> Therefore I can't use
> config SGI_IOC4
>     tristate
>     prompt "SGI IOC4 Base IO support" if PROMPT_FOR_UNUSED_CORES
>     depends on (IA64_GENERIC || IA64_SGI_SN2) && MMTIMER
>     default n
> 
> to hide this option unless PROMPT_FOR_UNUSED_CORES is selected.
> 
> Since the "if" is useless, misleading and redundand with this behaviour, I 
> suggest stripping it out.

"if" is valuable in "default y" cases.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

