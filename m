Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUDFLln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUDFLlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:41:40 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:32173 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263791AbUDFLkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:40:40 -0400
Date: Tue, 6 Apr 2004 07:27:08 -0400
From: Ben Collins <bcollins@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ieee1394 missing include
Message-ID: <20040406112708.GI1947@phunnypharm.org>
References: <Pine.GSO.4.58.0404061331580.4158@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0404061331580.4158@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Already fixed in my tree. Getting ready to sync with Linus today.

On Tue, Apr 06, 2004 at 01:32:37PM +0200, Geert Uytterhoeven wrote:
> 
> in_interrupt() needs <linux/sched.h> on some platforms
> 
> --- linux-2.6.5/drivers/ieee1394/csr1212.h.orig	2004-02-29 09:31:37.000000000 +0100
> +++ linux-2.6.5/drivers/ieee1394/csr1212.h	2004-02-29 12:37:11.000000000 +0100
> @@ -37,6 +37,7 @@
>  #include <linux/types.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
> +#include <linux/sched.h>
> 
>  #define CSR1212_MALLOC(size)		kmalloc((size), in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
>  #define CSR1212_FREE(ptr)		kfree(ptr)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
