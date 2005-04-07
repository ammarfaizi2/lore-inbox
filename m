Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVDGKak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVDGKak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDGKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:30:40 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:30419 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262422AbVDGKaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:30:25 -0400
Date: Thu, 7 Apr 2005 12:30:18 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407103018.GA22906@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <87d5t73pnf.fsf@osv.topcon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d5t73pnf.fsf@osv.topcon.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2005, Sergei Organov wrote:

> David Woodhouse <dwmw2@infradead.org> writes:
> 
> > On Wed, 2005-04-06 at 08:42 -0700, Linus Torvalds wrote:
> > > PS. Don't bother telling me about subversion. If you must, start reading
> > > up on "monotone". That seems to be the most viable alternative, but don't
> > > pester the developers so much that they don't get any work done. They are
> > > already aware of my problems ;)
> > 
> > One feature I'd want to see in a replacement version control system is
> > the ability to _re-order_ patches, and to cherry-pick patches from my
> > tree to be sent onwards. The lack of that capability is the main reason
> > I always hated BitKeeper.
> 
> darcs? <http://www.abridgegame.org/darcs/>

Close. Some things:

1. It's rather slow and quite CPU consuming and certainly I/O consuming
   at times - I keep, to try it out, leafnode-2 in a DARCS repo, which
   has a mere 20,000 lines in 140 files, with 1,436 changes so far, on a
   RAID-1 with two 7200/min disk drives, with an Athlon XP 2500+ with
   512 MB RAM. The repo has 1,700 files in 11.5 MB, the source itself
   189 files in 1.8 MB.

   Example: darcs annotate nntpd.c takes 23 s. (2,660 lines, 60 kByte)

   The maintainer himself states that there's still optimization required.

2. It has an impressive set of dependencies around Glasgow Haskell
   Compiler. I don't personally have issues with that, but I can already
   hear the moaning and bitching.

3. DARCS is written in Haskell. This is not a problem either, but I'd
   think there are fewer people who can hack Haskell than people who
   can hack C, C++, Java, Python or similar. It is still better than
   BitKeeper from the hacking POV as the code is available and under an
   acceptable license.

Getting DARCS up to the task would probably require some polishing, and
should probably be discussed with the DARCS maintainer before making
this decision.

Don't get me wrong, DARCS looks promising, but I'm not convinced it's
ready for the linux kernel yet.

-- 
Matthias Andree
