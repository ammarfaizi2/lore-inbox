Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279037AbRJ2G2V>; Mon, 29 Oct 2001 01:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279036AbRJ2G2L>; Mon, 29 Oct 2001 01:28:11 -0500
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:12773 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279037AbRJ2G2E>; Mon, 29 Oct 2001 01:28:04 -0500
Message-ID: <3BDCF71B.D89C5E79@mandrakesoft.com>
Date: Mon, 29 Oct 2001 01:28:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.4.13 remove unused warnings on module tables
In-Reply-To: <4680.1004336672@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 29 Oct 2001 01:17:15 -0500,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Keith Owens wrote:
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/spinlock.h>
> >>  #include <linux/list.h>
> >>
> >> +#ifndef CONFIG_KBUILD_2_5
> >>  #ifdef __GENKSYMS__
> >>  #  define _set_ver(sym) sym
> >>  #  undef  MODVERSIONS
> >> @@ -21,6 +22,7 @@
> >>  #   include <linux/modversions.h>
> >>  # endif
> >>  #endif /* __GENKSYMS__ */
> >> +#endif /* CONFIG_KBUILD_2_5 */
> >>
> >>  #include <asm/atomic.h>
> >>
> >> @@ -257,8 +259,6 @@ static const unsigned long __module_##gt
> >
> >I don't think we need this part of the patch.
> 
> It is a small change to module.h that is required for kbuild 2.5 and
> has no effect on 2.4.  Saves me having to send another patch later.

If everybody did this Linus would get 1001 unnecessary changes for 1002
patches...

Look, this isn't 2.5.   Everyone else has to separate out their 2.5
patches.  You're not special, you need to do it too...  Let's actually
take another half-second when sending patches to make sure Linus only
gets the changes destined for 2.4.  Keep the patch noise down, and help
out not only Linus but everyone else reviewing 2.4 code.

	Jeff, keeper of tree purity


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

