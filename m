Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSKYWxE>; Mon, 25 Nov 2002 17:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSKYWxE>; Mon, 25 Nov 2002 17:53:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51695 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265851AbSKYWxD>; Mon, 25 Nov 2002 17:53:03 -0500
Date: Tue, 26 Nov 2002 00:00:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Voyager subarchitecture (and other subarch updates) for 2.5.49
Message-ID: <20021125230011.GB24796@fs.tum.de>
References: <200211251625.gAPGPup02807@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211251625.gAPGPup02807@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 10:25:56AM -0600, James Bottomley wrote:

> This patch adds
>...
> - Subarchitecture menu (Adrian Bunk)
>...

Thanks for adding it, just a note that this diff includes a version that
is different from the one I sent (that's no problem for me, you know
more about Voyager than I do).

> James

Content-Description: voyager-2.5.49.diff
>...
> --- a/arch/i386/Kconfig	Mon Nov 25 10:17:13 2002
> +++ b/arch/i386/Kconfig	Mon Nov 25 10:17:13 2002
>...
>  config MCA
>  	bool "MCA support"
> -	depends on !VISWS
> +	depends on !VISWS && !VOYAGER
>  	help
>  	  MicroChannel Architecture is found in some IBM PS/2 machines and
>  	  laptops.  It is a bus system similar to PCI or ISA. See
>  	  <file:Documentation/mca.txt> (and especially the web page given
>  	  there) before attempting to build an MCA bus kernel.
>  
> +config MCA
> +	depends on VOYAGER
> +	default y if VOYAGER
>...


I'm not sure whether the latter works. My original patch included a

config MCA
       bool
       depends on VOYAGER

instead. This makes it more clear that it is actually what was called
define_bool in the old kconfig (even if it works a "default" entry in a
define_bool sounds really strange).


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


