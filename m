Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUBRNQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUBRNQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:16:10 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:48564 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S264473AbUBRNQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:16:05 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][0/6] A different KGDB stub
Date: Wed, 18 Feb 2004 18:45:01 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       linux-kernel@vger.kernel.org,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Andi Kleen <ak@suse.de>, George Anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>, Matt Mackall <mpm@selenic.com>
References: <20040217220236.GA16881@smtp.west.cox.net> <200402181026.29813.amitkale@emsyssoft.com> <20040218125647.GA4706@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040218125647.GA4706@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402181845.01628.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 Feb 2004 6:26 pm, Pavel Machek wrote:
> Hi!
>
> > > > > The following is my next attempt at a different KGDB stub
> > > > > for your tree
> > > >
> > > > Is this the patch which everyone agrees on?
> > >
> > > It is based on Amit's version, so I think answer is "yes". I certainly
> > > like this one.
> >
> > I don't agree. I did a few more cleanups after Andi expressed concerns
> > over globals kgdb_memerr and debugger_memerr_expected.
> >
> > I liked Pavel's approach. Let's first get a minimal kgdb stub into
> > mainline kernel. Even this much is going to involve some effort. We can
> > merge other features later.
> >
> > Let's create a cvs tree at kgdb.sourceforge.net for kgdb components to be
> > pushed int mainline kernel. This split is to keep current kgdb
> > unaffected. People who are already using it won't be affected.
>
> I do not think we want separate CVS tree.
>
> What about simply splitting core.patch into core-lite.patch and
> core.patch, maybe do the same with i386 patch, and be done with that?
> [We do not have enough people for a fork, I think].

Agreed. Let's create core-lite.patch and i386-lite.patch
It makes it somewhat difficult to maintain them, but should be easier than 
maintaining a separate CVS tree.

>
> Hopefully soon after that *-lite is merged, so it disappears, and
> stuff is easy once again.

Yes.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

