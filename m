Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263108AbTCLJOO>; Wed, 12 Mar 2003 04:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbTCLJOO>; Wed, 12 Mar 2003 04:14:14 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:17455 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S263108AbTCLJON>; Wed, 12 Mar 2003 04:14:13 -0500
Date: Wed, 12 Mar 2003 10:17:40 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Richard Henderson <rth@twiddle.net>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303120916430.17121-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.30.0303121001070.17121-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> On Wed, 12 Mar 2003, Richard Henderson wrote:
> > > This bug is in most 2.95, 2.96 and according to Alan in 3.0 and early
> > > 3.1) and people would just start "working around" it by commenting out
> > > the check for getting something to work quickly then forgetting about
> > > the issue completely.
> >
> > The bug report I can find,
> >
> >    http://gcc.gnu.org/ml/gcc-patches/2001-06/msg00746.html
> >
> > was fixed before gcc 3.0.0 was released.  So if this is
> > a different bug...
>
> Could be also the classical "copy-paste [slightly change one occasion]
> then fix one occasion" type of bug? I've never looked the quality of
> the gcc source. I really don't know.

Sorry, looks "a bit" more complex. And quoting you "Confirmed. I'd
classify this as a fairly serious bug. I am currently testing the
following fix."

I can confirm that Red Hat 7.3 latest gcc errata fixes (issued 13
months later) indeed generates correct code for at least
__ntfs_init_inode() with Randy's .config file. The compiler version,

% gcc --version
2.96

Oops, not to talkative considering how heavily patched ...

% rpm -qf =gcc
gcc-2.96-113

gcc generated code from Mandrake 9.1 RC2 is also ok.

% gcc --version
gcc (GCC) 3.2.2 (Mandrake Linux 9.1 3.2.2-2mdk)

	Szaka

