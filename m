Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVKASgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVKASgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVKASgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:36:23 -0500
Received: from duke.math.cinvestav.mx ([148.247.14.23]:32264 "EHLO duke")
	by vger.kernel.org with ESMTP id S1751103AbVKASgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:36:22 -0500
Date: Tue, 1 Nov 2005 12:35:34 -0600
From: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: Patch that allows >=2.6.12 kernel to build on nls free systems
Message-ID: <20051101123534.39d273c3@dune.math.cinvestav.mx>
In-Reply-To: <29495f1d0511010913l540ce99bkc9488fa21c0a250b@mail.gmail.com>
References: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
	<29495f1d0511010913l540ce99bkc9488fa21c0a250b@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It was caused by my copy/pasting error.

On Tue, 1 Nov 2005 09:13:50 -0800
Nish Aravamudan <nish.aravamudan@gmail.com> wrote:

> On 10/26/05, Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx> wrote:
> > diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/Makefile linux-2.6.14_rc2/scripts/kconfig/Makefile
> > --- linux-2.6.14_rc2.orig/scripts/kconfig/Makefile      2005-11-06 04:13:01 +0000
> > +++ linux-2.6.14_rc2/scripts/kconfig/Makefile   2005-11-18 03:52:03 +0000
> > @@ -116,6 +116,15 @@
> >  clean-files    := lkc_defs.h qconf.moc .tmp_qtcheck \
> >                    .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
> >
> > +# Needed for systems without gettext
> > +KBUILD_HAVE_NLS := $(shell \
> > +     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \

The file name is libintl.h and not libint.h (patch in the next e-mail)

> 
> Looks like this patch was merged:
> 
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=70a6a0cb92f24fd6bbe2e75299168909f735676a
> 
> I noticed with builds of -git3/-git4, I get the following complaints
> from oldconfig:
> 
> scripts/kconfig/mconf.c: In function `main':
> scripts/kconfig/mconf.c:1048: warning: statement with no effect
> scripts/kconfig/mconf.c:1049: warning: statement with no effect

This should be the output on nls free systems, but all systems were
detected as nls free because of that error.

> Not a big deal, just more complaints to have to see during the build
> process (with CONFIG_NLS=y) :)
> 
> Thanks,
> Nish

Sorry for this mistake.

Yuri.

