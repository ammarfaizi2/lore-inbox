Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBEWuy>; Mon, 5 Feb 2001 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135881AbRBEWuo>; Mon, 5 Feb 2001 17:50:44 -0500
Received: from bgnet.bg ([212.56.2.2]:54032 "EHLO bgnet.bg")
	by vger.kernel.org with ESMTP id <S129055AbRBEWui>;
	Mon, 5 Feb 2001 17:50:38 -0500
Date: Tue, 6 Feb 2001 01:02:08 +0000 (UTC)
From: Vesselin Atanasov <vesselin@bgnet.bg>
To: Admin Mailing Lists <mlist@intergrafix.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rlim_t and DNS?
In-Reply-To: <Pine.LNX.4.10.10102051339460.18021-100000@athena.intergrafix.net>
Message-ID: <Pine.LNX.4.10.10102060056060.2964-100000@bgnet.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Just edit lib/isc/unix/resource.c and find following line:
"typedef quad_t rlim_t"

replace it with
"typedef unsigned long rlim_t"

In my case I had also to #undef HAVE_LINUX_CAPABILITY_H in config.h
after running ./configure

This was enough for my libc5 machine.

Regards,
Vesselin Atanasov

On Mon, 5 Feb 2001, Admin Mailing Lists wrote:

> 
> Yep, it is libc5. i have 1 glibc system and they both have the files
> you've mentioned. :( either i'll have to upgrade to glibc (no small task)
> or use 8.2.3 for now..the previous 8.2.2 series was compiling ok for me.
> Unless someone has a workaround i might try for 9?
> 
> -Tony
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
> Anthony J. Biacco                       Network Administrator/Engineer
> thelittleprince@asteroid-b612.org       Intergrafix Internet Services
> 
>     "Dream as if you'll live forever, live as if you'll die today"
> http://www.asteroid-b612.org                http://www.intergrafix.net
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
> 
> On Thu, 1 Feb 2001, Peter Samuelson wrote:
> 
> > 
> > [Admin Mailing Lists]
> > > i have no bits directory
> > 
> > Really?  What version of libc, and on what Linux distro?  I thought all
> > versions of glibc2 had /usr/include/bits/.
> > 
> > If you are using libc4 or libc5, it is not surprising if the BIND
> > people didn't notice the problem -- they probably didn't try it.
> > 
> > Peter

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
