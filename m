Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270174AbRHGJ67>; Tue, 7 Aug 2001 05:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270173AbRHGJ6t>; Tue, 7 Aug 2001 05:58:49 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:58640 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270172AbRHGJ6q>; Tue, 7 Aug 2001 05:58:46 -0400
Date: Thu, 2 Aug 2001 13:44:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        kernel <linux-kernel@vger.kernel.org>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010802134437.B88@toy.ucw.cz>
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de> <3B65C3D4.FF8EB12D@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B65C3D4.FF8EB12D@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 12:30:12AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
> > > > everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
> > > > work).  That is the reason why it is a) marked experimental and is completly
> > > > unsupported (and that is written _big_ _fat_ in manuals and similar stuff)
> > > > and b) has debugging enabled to have the additional sanity checks that are
> > > > under this option and give addtional hints if reiserfs fails again.
> > >
> > > The debugging won't prevent a single crash, it will only print a diagnostic that
> > > might help to understand why it crashed.
> > 
> > I don't know when you took a look at you code the last time, but when
> > I did some time before the COL 3.1 release, there were lots of places
> > in the reiserfs code where functions assumed that they have valid
> > arguments when compiled without debugging and did the check explicitly
> > when compiled with.  Given the state the reiserfs code is in I really
> > prefer to see this option turned on.
> 
> But there is not one where they recover from invalid arguments without a panic
> (unless I failed to notice something), so it gets you nothing except a message
> that we the developers will find more informative when trying to find what made
> it crash.  We check invalid arguments at entry to reiserfs, and for those we

It is better to panic() immediately than "maybe crash" later.

Unless reiserfs is totaly screwed up, CONFIG_CHECKING can not make it *less*
stable -- that's why I understand people turning it on for distributions. Its
*their* choice, not yours.					Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

