Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSL2WdX>; Sun, 29 Dec 2002 17:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSL2WdW>; Sun, 29 Dec 2002 17:33:22 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9476 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262040AbSL2Wcf>;
	Sun, 29 Dec 2002 17:32:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212292240.gBTMeRYb000408@darkstar.example.net>
Subject: Re: [PATCH] more deprectation bits
To: akpm@digeo.com (Andrew Morton)
Date: Sun, 29 Dec 2002 22:40:27 +0000 (GMT)
Cc: hch@lst.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3E0F7684.6D07D4FB@digeo.com> from "Andrew Morton" at Dec 29, 2002 02:26:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Even if it's safe in that particular case, most code in the kernel runs
> > > > without BKL.  This patch just makes the deprication of sleep_on
> > > > explicit.
> > >
> > > This would be more appropriate:
> > 
> > I don't think so.  As you said before sleep_on is perfectly fine for
> > the small part of code still covered by BKL, so we should not impose
> > any runtime overhead (i.e. warnings) but rather remind at compile time.

Especially as the fact that EXT-3 makes use of it doesn't affect
anybody writing user land apps.  There isn't much point in warning
about things that are only relevant to readers of this list anyway.

> > That's what's so nice with the gcc extension (and you won't see it
> > anyway as long as you stay at egcs 1.1 :))

How long are we staying at 2.95.3 as the recommended compiler?  A lot
of people have been using 3.x with the 2.5 tree successfully for a
while.  What will be the recommended compiler for 2.6?

> Others will.  It will result in developers being distracted into "fixing"
> non-bugs.  It will introduce risk and it will delay the release of the
> 2.6 kernel.

featurefreeze()
{

> Please concentrate on things which *matter*.  Focus on getting this piece
> of software into a deliverable state and do not be distracted into futzing
> about with stuff which clearly was not addressed at the appropriate time.

}

John.
