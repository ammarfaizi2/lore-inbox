Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbTCLPYp>; Wed, 12 Mar 2003 10:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCLPYp>; Wed, 12 Mar 2003 10:24:45 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:25656 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261728AbTCLPYn>; Wed, 12 Mar 2003 10:24:43 -0500
Date: Wed, 12 Mar 2003 16:28:21 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Richard Henderson <rth@twiddle.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303121001070.17121-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.30.0303121101590.17436-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> > On Wed, 12 Mar 2003, Richard Henderson wrote:
> > > > This bug is in most 2.95, 2.96 and according to Alan in 3.0 and early
> > > > 3.1) and people would just start "working around" it by commenting out
> > > > the check for getting something to work quickly then forgetting about
> > > > the issue completely.
> > >
> > > The bug report I can find,
> > >
> > >    http://gcc.gnu.org/ml/gcc-patches/2001-06/msg00746.html
> > >
> > > was fixed before gcc 3.0.0 was released.  So if this is
> > > a different bug...

Some data points, in time order.

SuSE 8.0 	2.95.3-216      no bug yet [1]
Debian 3.0      2.95.4-14       no bug yet [1]
Red Hat 7.[23]  2.96-81         no bug yet [2,3]
Red Hat 7.[23]  2.96-98         bug introduced [2,3]
Mandrake 8.1    2.96-0.62mdk    bug introduced [4]
Red Hat 7.[23]  2.96-103        bug fixed  [2,3]
SuSE 8.0        3.0.4 (SuSE)    bug fixed [1]
Mandrake 9.1    3.2.2-2mdk      bug fixed [1]

[1] I checked
[2] http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=57760
[3] https://rhn.redhat.com/errata/RHBA-2002-055.html
[4] http://bugme.osdl.org/show_bug.cgi?id=432

So it's not so serious as we first thought. Probably the "halt build
if broken compiler detected" approach is enough.

	Szaka

