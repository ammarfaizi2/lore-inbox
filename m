Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289987AbSA3RrI>; Wed, 30 Jan 2002 12:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290063AbSA3Rpn>; Wed, 30 Jan 2002 12:45:43 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:46240
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289954AbSA3QTM>; Wed, 30 Jan 2002 11:19:12 -0500
Date: Wed, 30 Jan 2002 09:18:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130161825.GM25973@opus.bloom.county>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county> <20020130080308.D18381@work.bitmover.com> <20020130160707.GL25973@opus.bloom.county> <20020130081134.F18381@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130081134.F18381@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:11:34AM -0800, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 09:07:07AM -0700, Tom Rini wrote:
> > On Wed, Jan 30, 2002 at 08:03:08AM -0800, Larry McVoy wrote:
> > > On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > > > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > > > It does in some ways anyhow.  Following things downstream is rather
> > > > painless, but one of the things we in the PPC tree hit alot is when we
> > > > have a new file in one of the sub trees and want to move it up to the
> > > > 'stable' tree
> > > 
> > > Summary: only an issue because Linus isn't using BK.
> > 
> > Then how do we do this in the bk trees period?  To give a concrete
> > example, I want to move arch/ppc/platforms/prpmc750_setup.c from
> > 2_4_devel into 2_4, without loosing history.  How?  And just this file
> > and not all of _devel.
> 
> That question doesn't parse.  There are multiple ways you can do it but 
> once you do patches will no longer import cleanly from Linus.  The whole
> point of the pristine tree is to give yourself a tree into which you can
> import Linus patches.  If you start putting extra stuff in there you will
> get patch rejects.

Er, not the pristine tree, the linuxppc_2_4 tree, sorry.  I'll try
again.  One of the problems we hit frequently is that we have to move
files from linuxppc_2_4_devel into linuxppc_2_4, once they prove stable.
But just creating a normal patch, or cp'ing the files means when we pull
linuxppc_2_4 back into linuxppc_2_4_devel we get a file conflict, and
have to move one of the files (the previously existing one) into the
deleted dir.  How do we cleanly move just a few files from a child tree
into the parent?  I think this is a lot like what would happen, if Linus
used BK and we wanted to send him support for some platforms, but not
all of the other changes we have.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
