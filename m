Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUEULli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUEULli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUEULlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:41:37 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:36480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265805AbUEULle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:41:34 -0400
Date: Fri, 21 May 2004 13:41:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040521114125.GA10052@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521111828.GA870@gondor.apana.org.au> <20040521112209.GA951@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521112209.GA951@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > --- tmp/linux/arch/i386/mm/init.c       2004-05-20 23:08:05.000000000 +0200
> > > > > +++ linux/arch/i386/mm/init.c   2004-05-20 23:10:50.000000000 +0200
> > > > > @@ -331,6 +331,13 @@
> > > > > void zap_low_mappings (void)
> > > > > {
> > > > >        int i;
> > > > > +
> > > > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > > > 
> > > > Can you please define this for CONFIG_PM_DISK as well? Alternatively,
> > > > you can do the same as you did in cpu.c and define this for
> > > > CONFIG_PM.
> 
> Would you object to a patch that converted current uses of
> CONFIG_SOFTWARE_SUSPEND/CONFIG_PM to a new symbol that is
> turned on iff one of CONFIG_SOFTWARE_SUSPEND/CONFIG_PM_DISK
> is enabled?

I guess that open-coding #if defined() || defined() is right thing to
do for now.

Suspend2 when/if merged might not need this... This one is not really
specific to suspend-to-disk. It is specific to swsusp way of doing
things, which happens to be same as pmdisk way of doing it...
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
