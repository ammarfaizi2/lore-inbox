Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTBPAe7>; Sat, 15 Feb 2003 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTBPAe7>; Sat, 15 Feb 2003 19:34:59 -0500
Received: from [81.2.122.30] ([81.2.122.30]:64004 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265423AbTBPAe6>;
	Sat, 15 Feb 2003 19:34:58 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302160046.h1G0k9IA000718@darkstar.example.net>
Subject: Re: openbkweb-0.0
To: arashi@yomerashi.yi.org (Matt Reppert)
Date: Sun, 16 Feb 2003 00:46:08 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030215181517.11430d53.arashi@yomerashi.yi.org> from "Matt Reppert" at Feb 15, 2003 06:15:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I always thought that that is what the bk-commit mailing lists were
> > > > for?  I could be wrong about that, not having used BitKeeper - if so,
> > > > what are they for, and would it not be possible to simply have a
> > > > mailing list which got sent a diff every time Linus' updated his tree?
> > > 
> > > The latest diff against the last-released kernel is always available
> > > at http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/
> > > 
> > > "Gzipped full patch from ..."
> > 
> > So it's perfectly possible to poll
> > http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/ every half
> > hour or so, 
> 
> Well, the diff is made daily, at some relatively early time during the
> morning in one of the time zones continental US is in. I think it's 4am
> GMT -0800, but I could be wrong.

Are you sure?  At the moment, the latest changeset is 1.1027, made at
12:49:07 -08:00 today.  That's just under four hours ago.

In any case, it would be better not to have to poll a website to get
updates, but have them actively delivered by smtp, which brings us
back to what I first suggested:

Why can't we have a mailing list that sends out a diff for each
update?

That way, all you need is:

:0
* ^X-Mailing-List: up-to-the-second-linux-patches
| /usr/local/bin/apply_patches

and

#!/bin/sh
cd /usr/src/linux-current
cat | patch -p1
mail $username

John,
