Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSBZXok>; Tue, 26 Feb 2002 18:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSBZXoi>; Tue, 26 Feb 2002 18:44:38 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:13188 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S289255AbSBZXnh>;
	Tue, 26 Feb 2002 18:43:37 -0500
Subject: Re: Whither XFS? (was: Congrats Marcelo)
From: Steve Lord <lord@sgi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Dilger <adilger@turbolabs.com>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16f90h-0002rt-00@starship.berlin>
In-Reply-To: <E16fqZK-0002NE-00@the-village.bc.nu>
	<1014764374.5993.183.camel@jen.americas.sgi.com> 
	<E16f90h-0002rt-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 17:39:48 -0600
Message-Id: <1014766788.9994.231.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-24 at 18:28, Daniel Phillips wrote:
> > 
> >   o Posix ACL support
> 
> Are you able to leverage the new EA interface?  (Which I still don't like
> because of the namespace syntax embedded in the attribute names, btw,
> please don't misinterpret silence as happiness.)

Where do you think the interface originated? A lot of time was spent
working on this and getting the ext2 and xfs code bases in sync.

> 
> >   o The ability to do online filesystem dumps which are coherent with
> >     the system call interface
> 
> It would be nice if some other filesystems could share that mechanism, do
> you think it's feasible?  If not, what's the stumbling block?  I haven't
> looked at this for some time and there's was some furious work going on
> exactly there just before 2.5.  It seems we've at least progressed a
> little from the viewpoint that nobody would want that.

Not really, there are some hooks into XFS which are probably totally
non-trivial for other filesystems.

> 
> >   o delayed allocation of file data
> 
> Andrew Morton is working on generic delayed allocation at the vfs level I
> believe, why not bang heads with him and see if it can be made to work with
> VFS?

Already talked at the end of last week, got majorly sidetracked again
this week. This is definitely something I would like to be able to
leverage for XFS. 

> 
> >   o DMAPI
> 
> It would be nice to have unsucky file events.  But there's been roughly zero
> discussion of dmapi on lkml as far as I can see.

Yep, and its not my strong suite. The previous attempt at an implementation
by someone else appears to have died a death.

> 
> > As it is we did all of these, and we seem to have half the Linux NAS
> > vendors in the world building xfs into their boxes.
> 
> True enough.

Now if only we could make some money out of them ;-)

Steve

> 
> -- 
> Daniel
-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
