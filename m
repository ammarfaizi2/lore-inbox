Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVF1VRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVF1VRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVF1VRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:17:04 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:36552 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261327AbVF1UDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:03:40 -0400
Date: Tue, 28 Jun 2005 22:03:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Robert Love <rml@novell.com>, Andy Isaacson <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
Message-ID: <20050628200330.GB4453@wohnheim.fh-wedel.de>
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628194128.GM4645@bouh.labri.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 21:41:28 +0200, Samuel Thibault wrote:
> Robert Love, le Tue 28 Jun 2005 15:23:43 -0400, a �crit :
> > I think we need to resolve the differences between the man pages,
> > comments, expected user behavior, kernel implementation, POSIX standard,
> > and what other OS's do.  Figure out what to do, then unify everything.
> 
> Well, posix says data should be kept. The solaris man page for madvise,
> since it proposes a MADV_FREE case too do agree with posix.

Plus, common sense agrees with posix.  An implementation of madvice
that doesn't do anything should be perfectly sane and functionally
equivalent to any other implementation.  Only differences should be in
performance.

Dropping dirty pages is a clear functional difference.

> I've tested the program (thanks Andy) on solaris 5.8, it does work fine.
> On OSF1 it failed on the anonymous case.
> 
> Some people may want their data to be kept, so the safe side is to keep
> data safe, i.e. both kernel and manpage be corrected, but leave a bug
> notice in the manpage about previous kernels.

Sounds sane.

J�rn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm � I could do better than that!"
-- Douglas Adams in a slashdot interview
