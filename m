Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUBYLLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUBYLLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:11:39 -0500
Received: from gprs147-32.eurotel.cz ([160.218.147.32]:43392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261245AbUBYLLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:11:38 -0500
Date: Wed, 25 Feb 2004 12:10:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Message-ID: <20040225111043.GD214@elf.ucw.cz>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz> <200402251629.42302.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402251629.42302.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > kgdb uses really confusing names for arch-dependend parts. This fixes
> > > > it. Okay to commit?
> > >
> > > Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is
> > > indicative of architecture dependent code in it. Err, well so is the
> > > path.
> >
> > Well, looking at i386-stub.c, how do you know it is kgdb-related?
> 
> hmm... I see what you meant by "confusing". The confusing part is file name 
> not representing contents. Agreed.
> 
> > > PPC and sparc stubs in present vanilla kernel use this naming convention.
> > > That's why I adopted it.
> > >
> > > I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent
> > > compared to kernel/kgdbstub.c, arch/$x/kernel/kgdb.c
> >
> > I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe
> 
> OOPS I didn't notice that.
> 
> > there's no point where one could be confused....
> 
> kernel/kgdb.c and arch/*kernel/kgdb.c have same file name appearing in two 
> places :-( mainline kernel also does it (e.g. ptrace.c)
> 
> Let's  go with the convention followed in mainline kernel.
> OK from me.

Now you confused me :-). I commited rename of arch/*/kernel/*-stub.c
into arch/*/kernel/kgdb.c.

Should I commit rename of kernel/kgdbstub.c into kernel/kgdb.c, too?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
