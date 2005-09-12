Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVILFwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVILFwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 01:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVILFwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 01:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:20122 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750717AbVILFwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 01:52:46 -0400
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] x86_64 linker script cleanups for debug sections
References: <20050910174452.907256000@zion.home.lan>
	<20050910174628.104571000@zion.home.lan>
From: Andi Kleen <ak@suse.de>
Date: 12 Sep 2005 07:52:42 +0200
In-Reply-To: <20050910174628.104571000@zion.home.lan>
Message-ID: <p738xy24ytx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:

> Use the new macros for x86_64 too.
> 
> Note that the current scripts includes different definitions; more exactly,
> it only contains part of the DWARF2 sections and the .comment one from
> Stabs. Shouldn't be a problem, anyway.

Can you please always cc me on any arch/x86_64,asm-x86_64 patches? 

> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  arch/x86_64/kernel/vmlinux.lds.S |   17 ++---------------
>  1 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
> --- a/arch/x86_64/kernel/vmlinux.lds.S
> +++ b/arch/x86_64/kernel/vmlinux.lds.S
> @@ -194,20 +194,7 @@ SECTIONS
>  #endif
>  	}
>  
> -  /* DWARF 2 */
> -  .debug_info     0 : { *(.debug_info) }
> -  .debug_abbrev   0 : { *(.debug_abbrev) }
> -  .debug_line     0 : { *(.debug_line) }
> -  .debug_frame    0 : { *(.debug_frame) }
> -  .debug_str      0 : { *(.debug_str) }
> -  .debug_loc      0 : { *(.debug_loc) }
> -  .debug_macinfo  0 : { *(.debug_macinfo) }
> -  /* SGI/MIPS DWARF 2 extensions */
> -  .debug_weaknames 0 : { *(.debug_weaknames) }
> -  .debug_funcnames 0 : { *(.debug_funcnames) }
> -  .debug_typenames 0 : { *(.debug_typenames) }
> -  .debug_varnames  0 : { *(.debug_varnames) }
> +  STABS_DEBUG

There are no stabs sections on x86-64

> -
> -  .comment 0 : { *(.comment) }
> +  DWARF_DEBUG

-Andi
