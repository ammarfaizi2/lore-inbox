Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSFRBxT>; Mon, 17 Jun 2002 21:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSFRBxS>; Mon, 17 Jun 2002 21:53:18 -0400
Received: from ns.suse.de ([213.95.15.193]:9224 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317260AbSFRBxR>;
	Mon, 17 Jun 2002 21:53:17 -0400
Date: Tue, 18 Jun 2002 03:53:12 +0200
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: kai@tp1.ruhr-uni-bochum.de, torvalds@transmeta.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.22] fix x86 initrd breakage
Message-ID: <20020618035312.A6714@wotan.suse.de>
References: <200206180055.CAA11524@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206180055.CAA11524@harpo.it.uu.se>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch below reverts the statement to its pre-2.5.17 state.
> Perhaps it should be removed altogether?
> 
> Cc: to Andi Kleen since it seems x86_64 also is affected by
> this bug.

Thanks. I removed that statement for x86-64 from my tree.

-Andi

> 
> --- linux-2.5.22/arch/i386/boot/Makefile.~1~	Tue Jun 11 14:18:07 2002
> +++ linux-2.5.22/arch/i386/boot/Makefile	Tue Jun 18 00:43:12 2002
> @@ -23,7 +23,7 @@
>  
>  # If you want the RAM disk device, define this to be the size in blocks.
>  
> -RAMDISK := -DRAMDISK=512
> +#RAMDISK := -DRAMDISK=512
