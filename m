Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbUBYLAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUBYLAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:00:09 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:31872 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261254AbUBYK77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:59:59 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Date: Wed, 25 Feb 2004 16:29:42 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com> <20040225103703.GB6206@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040225103703.GB6206@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402251629.42302.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 Feb 2004 4:07 pm, Pavel Machek wrote:
> Hi!
>
> > > kgdb uses really confusing names for arch-dependend parts. This fixes
> > > it. Okay to commit?
> >
> > Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is
> > indicative of architecture dependent code in it. Err, well so is the
> > path.
>
> Well, looking at i386-stub.c, how do you know it is kgdb-related?

hmm... I see what you meant by "confusing". The confusing part is file name 
not representing contents. Agreed.

> > PPC and sparc stubs in present vanilla kernel use this naming convention.
> > That's why I adopted it.
> >
> > I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent
> > compared to kernel/kgdbstub.c, arch/$x/kernel/kgdb.c
>
> I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe

OOPS I didn't notice that.

> there's no point where one could be confused....

kernel/kgdb.c and arch/*kernel/kgdb.c have same file name appearing in two 
places :-( mainline kernel also does it (e.g. ptrace.c)

Let's  go with the convention followed in mainline kernel.
OK from me.

-Amit


