Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSEVOma>; Wed, 22 May 2002 10:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSEVOlB>; Wed, 22 May 2002 10:41:01 -0400
Received: from bitmover.com ([192.132.92.2]:32445 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315441AbSEVOkk>;
	Wed, 22 May 2002 10:40:40 -0400
Date: Wed, 22 May 2002 07:40:41 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Htree directory index for Ext2, updated
Message-ID: <20020522074041.B12265@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178xSu-0000Dc-00@starship> <20020518172634.GK21295@turbolinux.com> <E17ASeO-0001xB-00@starship> <20020522102354.GB802@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 04:23:54AM -0600, Andreas Dilger wrote:
> On May 22, 2002  11:43 +0200, Daniel Phillips wrote:
> > On Saturday 18 May 2002 19:26, Andreas Dilger wrote:
> > > On May 18, 2002  08:13 +0200, Daniel Phillips wrote:
> > > > I cloned a repository that is arranged like:
> > > > 
> > > >   somedir
> > > >     |
> > > >     |--linux
> > > >     |    |
> > > >     |    The usual stuff
> > > >     |
> > > >      `---other things
> > > > 
> > > > Bitkeeper wants the destination for the import to be 'somedir', and
> > > > cannot figure out how to apply a patch that looks like:
> > > > +++ src/include/linux/someheader.h, for instance.
> > > 
> > > And that is bad in what way?
> > 
> > It is bad in that there is no way to import the patch into BitKeeper.
> > 
> > It looks like a hole in BitKeeper.  How do you suggest I apply my
> > perfectly normal patch?
> 
> cd somedir/linux; patch -p1 < foo.diff; bk citool

bk import -tpatch foo.diff somedir/linux

also works, does the same thing, but handles renames.  Not needed for
simple patches but you might get in the habit of using it anyway so
the odd rename is caught.

Cheers,
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
