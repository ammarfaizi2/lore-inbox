Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131105AbRCJSse>; Sat, 10 Mar 2001 13:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131115AbRCJSsY>; Sat, 10 Mar 2001 13:48:24 -0500
Received: from mailout1-100bt.midsouth.rr.com ([24.92.68.6]:45229 "EHLO
	mailout1-100bt.midsouth.rr.com") by vger.kernel.org with ESMTP
	id <S131105AbRCJSsO>; Sat, 10 Mar 2001 13:48:14 -0500
Message-Id: <200103101845.f2AIjuL10614@mailout1-100bt.midsouth.rr.com>
Subject: Re: Kernel 2.4.1 on RHL 6.2
From: Stephen "M." Williams <rootusr@midsouth.rr.com>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98drnp$qq0$1@ncc1701.cistron.net>
In-Reply-To: <001401c0a970$ec3c9b00$1d9509ca@pentiumiii>
	<200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com> 
	<98drnp$qq0$1@ncc1701.cistron.net>
Content-Type: text/plain
X-Mailer: Evolution (0.9/+cvs.2001.03.06.23.22 - Preview Release)
Date: 10 Mar 2001 12:44:44 -0600
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, I had no idea.  I was following advice I received a long time ago
from a mailing list.  If I remove those symlinks how do I go about
compiling the kernel without receiving the same errors as Srinath?

Thanks for the correction,

    Steve



On 10 Mar 2001 18:28:09 +0000, Miquel van Smoorenburg wrote:
> In article <200103101754.f2AHsUL04580@mailout1-100bt.midsouth.rr.com>,
> Stephen "M." Williams  <rootusr@midsouth.rr.com> wrote:
> >Make sure you have the following symlinks in your /usr/include
> >directory, assuming you're on an x86 machine:
> >
> >asm -> /usr/src/linux/include/asm-i386/
> >linux -> /usr/src/linux/include/linux/
> 
> Note! You only have to have those symlinks on broken systems such
> as Redhat.
> 
> Sane systems such as Debian have a copy of the kernel header files
> that the C library was compiled against in /usr/include/{linux,asm}
> instead of symlinks to the kernel source. Do not play the symlink
> trick on those systems.
> 
> Before this turns into a flamewar: this has been discussed 20 or
> so times before, and both Linus and the glibc developers agree
> that you a distribution should do the latter. The headers you use
> to compile userland binaries should be the same as the C library
> was compiled against.
> 
> If you need to compile a standalone module use -I/usr/src/linux/include
> 
> Mike.
> -- 
> Go not unto the Usenet for advice, for you will be told both yea and nay (and
> quite a few things that just have nothing at all to do with the question).
>       -- seen in a .sig somewhere
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

