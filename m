Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSFCWjB>; Mon, 3 Jun 2002 18:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSFCWjA>; Mon, 3 Jun 2002 18:39:00 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:12535 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S315690AbSFCWi6>; Mon, 3 Jun 2002 18:38:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Brad Hards <bhards@bigpond.net.au>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386 "General Options" - begone [take 2] 
In-Reply-To: Your message of "Mon, 03 Jun 2002 13:18:09 +1000."
             <200206031318.09634.bhards@bigpond.net.au> 
Date: Tue, 04 Jun 2002 08:42:47 +1000
Message-Id: <E17F0XH-0002ic-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200206031318.09634.bhards@bigpond.net.au> you write:
> While moving software suspend, I also took the chance to tweak the Config.help 
> entry.

For trivial at least, please split the patches.  It makes it easy for
me and/or Linus to accept only one.

Also, please mention clearly if you obsolete a previous trivial patch...

> diff -Naur -X dontdiff linux-2.5.20-clean/arch/i386/Config.help linux-2.5.20-
config-munging/arch/i386/Config.help
> --- linux-2.5.20-clean/arch/i386/Config.help	Thu May 30 04:42:46 2002
> +++ linux-2.5.20-config-munging/arch/i386/Config.help	Mon Jun  3 12:39:48 200
2
> @@ -641,7 +641,8 @@
>    off or put into a power conserving "sleep" mode if they are not
>    being used.  There are two competing standards for doing this: APM
>    and ACPI.  If you want to use either one, say Y here and then also
> -  to the requisite support below.
> +  to the requisite support below. This option is also required for
> +  "software suspend", see below.
>  
>    Power Management is most important for battery powered laptop
>    computers; if you have a laptop, check out the Linux Laptop home

Like code, descriptions develop scar tissue when you do the "minimally
invasive" change.  Consider this classic trap-for-skimmers from the
glibc "snprintf" man page, and learn:

Return value
       These  functions  return  the number of characters printed
       (not including the trailing `\0' used  to  end  output  to
       strings).   snprintf  and vsnprintf do not write more than
       size bytes (including the trailing '\0'), and return -1 if
       the  output  was truncated due to this limit.  (Thus until
       glibc 2.0.6. Since glibc 2.1 these  functions  follow  the
       C99  standard and return the number of characters (exclud­
       ing the trailing '\0') which would have  been  written  to
       the final string if enough space had been available.)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
