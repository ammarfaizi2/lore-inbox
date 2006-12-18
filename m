Return-Path: <linux-kernel-owner+w=401wt.eu-S1754240AbWLRQfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbWLRQfY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbWLRQfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:35:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2242 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754242AbWLRQfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:35:22 -0500
Date: Mon, 18 Dec 2006 17:35:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Remove reference to "depends" directive from Kconfig documentation.
Message-ID: <20061218163522.GE10316@stusta.de>
References: <Pine.LNX.4.64.0612181038560.26878@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181038560.26878@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:40:25AM -0500, Robert P. J. Day wrote:
> 
>   Remove from the documentation the notion of using "depends" rather
> than "depends on" in Kconfig files.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   given that there are only three Kconfig files left that still use
> "depends" rather than "depends on", there's no point encouraging
> anyone to still use it (although the parser itself still accepts both
> "depends" and "requires").
> 
> 
> diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
> index 536d5bf..658abb5 100644
> --- a/Documentation/kbuild/kconfig-language.txt
> +++ b/Documentation/kbuild/kconfig-language.txt
> @@ -77,7 +77,7 @@ applicable everywhere (see syntax).
>    Optionally, dependencies only for this default value can be added with
>    "if".
> 
> -- dependencies: "depends on"/"requires" <expr>
> +- dependencies: "depends on" <expr>
>    This defines a dependency for this menu entry. If multiple
>    dependencies are defined, they are connected with '&&'. Dependencies
>    are applied to all other options within this menu entry (which also

Your patch does something different:
It's not about "depends", it's about the unused alternative "requires".

Removing "requires" sounds reasonable (even for the implementation, not 
only the documentation), but that's different from what you were 
thinking about.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

