Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSLDMiB>; Wed, 4 Dec 2002 07:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSLDMiB>; Wed, 4 Dec 2002 07:38:01 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:33984 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266489AbSLDMh7>;
	Wed, 4 Dec 2002 07:37:59 -0500
Date: Wed, 4 Dec 2002 12:42:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021204124227.GB647@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204115819.GB1137@gallifrey>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 11:58:19AM +0000, Dr. David Alan Gilbert wrote:

 > > - architecture xxx doesn't compile
 > >   there's a few of these now in bugzilla, and personally I don't think
 > >   they belong there. Any arch other than i386 is always going to be
 > >   playing catchup, and is nearly always out of date in mainline.
 > 
 > Quite a few of those are from me.  It is a real pity that we keep the
 > view of everything other than i386 is playing catch up - that really
 > deminishes the usefulness of Linux in a lot of fields.

This was something that was brought up in a discussion at the kernel
summit by (I think) Paul Mackerras. The question was how to make
sure we get all arch's in sync before doing a release.
It should be fairly straightforward thing to do for 2.6.x releases,
but during 2.5.x when stuff is changing so rapidly, it doesn't make
sense to hold up the majority of users just so the other archs can
play catch up.

 > Don't forget that ia64, x86-64 and s390 are all potentially growing
 > users of Linux.

ia64 and x86-64 maybe, but s390 is way out of the pricerange of most
Linux users. Those who can afford it will likely use distro kernels anyway
due to the added support they paid for.

x86-64 usually isn't that far from mainline (though there was a period
a while ago, where Linus hadn't merged for a while).  As most of that
is shared with i386 or very similar, I think when these become more
mainstream, we'll start seeing a lot more people contributing to this,
so it should remain current in mainline also, as long as Andi scales 8-)
 
 > Linux on ARM, MIPS and PPC also has a healthy band of
 > productive (commercial and home) users.

Russell has done a great job at keeping ARM up to date in 2.5,
as have the PPC folks.  For the most part, the archs aren't that
out of sync. (Insert comedy remark here about m68k being more
up to date than alpha).

 > I don't expect that all the other architectures will be as well tested
 > as x86; but at least we should know the state of each architecture and
 > preferably have 2.6.x (or whatever it gets called) to basically work on
 > as many architectures as possible.

indeed. this should be addressed by the time we get to stable releases.
One possibility someone came up with at the summit was just a slightly
different take on the existing pre/rc release model.
The initial pre's remain as they are now, later pres are for strict
bug-fixes and arch resyncs, then the release candidates roll out.
It doesn't sound that impossible a plan, as long as whoever ends up
doing it is strict enough not to include 'just one more feature'
during the arch-merge pre's.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
