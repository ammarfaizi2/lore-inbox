Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132277AbRAKRu3>; Thu, 11 Jan 2001 12:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131894AbRAKRuT>; Thu, 11 Jan 2001 12:50:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16400 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131615AbRAKRuJ>; Thu, 11 Jan 2001 12:50:09 -0500
Date: Thu, 11 Jan 2001 18:48:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010111184821.E828@athlon.random>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com> <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De> <20010111111145.A19584@gruyere.muc.suse.de> <3A5D8B79.AD1E161D@Hell.WH8.TU-Dresden.De> <20010111183605.A828@athlon.random> <20010111184645.B828@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010111184645.B828@athlon.random>; from andrea@suse.de on Thu, Jan 11, 2001 at 06:46:45PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:46:45PM +0100, Andrea Arcangeli wrote:
> Until I fix the 3dnow code to use the i387.c library please workaround
> this way:
> 
> --- ./arch/i386/config.in.~1~	Thu Jan 11 17:52:05 2001
> +++ ./arch/i386/config.in	Thu Jan 11 18:38:29 2001
> @@ -109,7 +109,7 @@
>     define_int  CONFIG_X86_L1_CACHE_SHIFT 6
>     define_bool CONFIG_X86_TSC y
>     define_bool CONFIG_X86_GOOD_APIC y
> -   define_bool CONFIG_X86_USE_3DNOW y
> +#   define_bool CONFIG_X86_USE_3DNOW y
>     define_bool CONFIG_X86_PGE y
>     define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
>  fi

Ah no, I even better, just pass `nofxsr` to the 2.4.1-pre2 kernel. (no
need to recompile)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
