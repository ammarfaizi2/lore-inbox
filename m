Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFBNXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTFBNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:23:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43006 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262316AbTFBNXp (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 09:23:45 -0400
Date: Mon, 2 Jun 2003 15:37:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
Message-ID: <20030602133705.GH29425@fs.tum.de>
References: <16088.47088.814881.791196@laputa.namesys.com> <1054406992.4837.0.camel@sherbert> <20030531185709.GK8978@holomorphy.com> <16091.14923.815819.792026@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16091.14923.815819.792026@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 03:51:39PM +0400, Nikita Danilov wrote:
>...
> --- 1.15/include/linux/compiler.h	Wed Apr  9 22:15:46 2003
> +++ edited/include/linux/compiler.h	Mon Jun  2 14:44:18 2003
>...
> +/* The attribute `const' is not implemented in GCC versions earlier than 2.5. */
> +/* Basically this is just slightly more strict class than the `pure'
> +   attribute */
> +#if (__GNUC__ > 2) || (__GNUC__ == 2 && __GNUC_MINOR__ >= 5)
> +#define __attribute_const __attribute__ ((__const__))
> +#else
> +#define __attribute_const
> +#endif
>...

gcc 2.95 is the oldest compiler supported in kernel 2.5, there's no need 
to be compatible with older compilers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

