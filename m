Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268776AbRG0Oti>; Fri, 27 Jul 2001 10:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRG0Ot3>; Fri, 27 Jul 2001 10:49:29 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:524 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S268776AbRG0OtS>;
	Fri, 27 Jul 2001 10:49:18 -0400
Message-ID: <3B617F34.FE1EE755@namesys.com>
Date: Fri, 27 Jul 2001 18:48:20 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

we all have different usage patterns and different needs.  I find it extremely convenient to not be
using ext2 when my dell laptop with its poor linux power management crashes frequently, or the
kernel crashes.   I have never had any problem with data corruption.  Many users I know have also
had good experiences with leaving behind ext2 and going to reiserfs on their laptops.  For your
needs and patterns though, it sounds like you need ext3.

Hans

bvermeul@devel.blackstar.nl wrote:
> 
> On Fri, 27 Jul 2001, Hans Reiser wrote:
> 
> > bvermeul@devel.blackstar.nl wrote:
> > >
> > > On Wed, 18 Jul 2001, Erik Mouw wrote:
> > >
> > > > On Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu wrote:
> > > > > My advice:
> > > > >
> > > > > Dont use reiserfs,JFS
> > > > > it is ok to use ext2
> > > > >
> > > > > Go journalling? use ext3 or XFS
> > > > >
> > > > > I have used  all of these fs and pick up this rule (up
> > > > > to now, not sure it remains right in the far  future)
> > > >
> > > > FUD. I've been using reiserfs on quite some systems and never got any
> > > > problem. If reiserfs wouldn't be stable, SuSE wouldn't have supported
> > > > it as one of their stable filesystems for over a year.
> > >
> > > Actually, I've been having some nasty corruption problems as well with
> > > reiserfs. I develop my own drivers, and do occasionally make a mistake,
> > > and when that hangs the kernel it will also screw up all files touched
> > > just before it in a edit-make-install-try cycle. Which can be rather
> > > annoying, because you can start all over again (this effect randomly
> > > distributes the last touched sectors to the last touched files. Very nice
> > > effect, but not something I expect from a journalled filesystem).
> >
> > Do you think it is reasonable to ask that a filesystem be designed to
> > work well with bad drivers?
> 
> Yup. I know ext2 can do it. I expect a filesystem to not foul up my data
> when something happens. Especially not shuffle around sectors in several
> files. I can understand that the changes I made are not on disc, I can
> even understand it if my files are gone, but not when it corrupts my data.
> That just plain sucks.
> 
> A friend of mine has had crashes as well (not reiser related btw), where
> files he was using at the time suddenly contained different pieces of
> different files. It's just plain annoying. The reason why *I* use(d)
> reiserfs was the fact that I thought that it would protect my data when
> something does crash. From my experience, it doesn't, and I'd rather wait
> a couple of minutes for ext2 to fsck than use reiserfs and be sure I can
> start all over again.
> 
> Regards,
> 
> Bas Vermeulen
> 
> --
> "God, root, what is difference?"
>         -- Pitr, User Friendly
> 
> "God is more forgiving."
>         -- Dave Aronson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
