Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVKASmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVKASmd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVKASmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:42:33 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:16791 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbVKASmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:42:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5hIcwaFPN94GtwSrRsF0d84zVqEYu+zl6JjWkcU1iMk1ZTlJGxWISBhITEGzLUJfv+HlrzHUHRWUEZXwe74numNhPmvABTUzWSoioaOLQ+G5utuMpiM6F3AYiNa2W6+OsBOiBN9t7l2OWgiHe1R5TRMWTgLwqejPQRegH6hKX0=
Message-ID: <29495f1d0511011042x6bb571c3tb8a4752173eadbbf@mail.gmail.com>
Date: Tue, 1 Nov 2005 10:42:31 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
Subject: Re: Patch that allows >=2.6.12 kernel to build on nls free systems
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>
In-Reply-To: <20051101123534.39d273c3@dune.math.cinvestav.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
	 <29495f1d0511010913l540ce99bkc9488fa21c0a250b@mail.gmail.com>
	 <20051101123534.39d273c3@dune.math.cinvestav.mx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx> wrote:
> Hi,
>
> It was caused by my copy/pasting error.
>
> On Tue, 1 Nov 2005 09:13:50 -0800
> Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>
> > On 10/26/05, Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx> wrote:
> > > diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/Makefile linux-2.6.14_rc2/scripts/kconfig/Makefile
> > > --- linux-2.6.14_rc2.orig/scripts/kconfig/Makefile      2005-11-06 04:13:01 +0000
> > > +++ linux-2.6.14_rc2/scripts/kconfig/Makefile   2005-11-18 03:52:03 +0000
> > > @@ -116,6 +116,15 @@
> > >  clean-files    := lkc_defs.h qconf.moc .tmp_qtcheck \
> > >                    .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
> > >
> > > +# Needed for systems without gettext
> > > +KBUILD_HAVE_NLS := $(shell \
> > > +     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
>
> The file name is libintl.h and not libint.h (patch in the next e-mail)

Makes sense.

> > Looks like this patch was merged:
> >
> > http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=70a6a0cb92f24fd6bbe2e75299168909f735676a
> >
> > I noticed with builds of -git3/-git4, I get the following complaints
> > from oldconfig:
> >
> > scripts/kconfig/mconf.c: In function `main':
> > scripts/kconfig/mconf.c:1048: warning: statement with no effect
> > scripts/kconfig/mconf.c:1049: warning: statement with no effect
>
> This should be the output on nls free systems, but all systems were
> detected as nls free because of that error.

Ah, I see.

> > Not a big deal, just more complaints to have to see during the build
> > process (with CONFIG_NLS=y) :)
> >
> > Thanks,
> > Nish
>
> Sorry for this mistake.

No worries, it didn't make the compile fail :) Thanks for the quick response!

Thanks,
Nish
