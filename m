Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTAUQzi>; Tue, 21 Jan 2003 11:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTAUQzi>; Tue, 21 Jan 2003 11:55:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13830 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267106AbTAUQzh>; Tue, 21 Jan 2003 11:55:37 -0500
Date: Tue, 21 Jan 2003 12:02:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Michal Jaegermann <michal@harddata.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] initrd/mkinitrd still not working
In-Reply-To: <20030120191838.A7174@mail.harddata.com>
Message-ID: <Pine.LNX.3.96.1030121115018.30858B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Michal Jaegermann wrote:

> On Mon, Jan 20, 2003 at 08:35:46PM +0100, Sam Ravnborg wrote:
> > On Mon, Jan 20, 2003 at 07:19:21PM +0000, John Levon wrote:
> > > Ooops, I was mis-remembering commit logs. I meant :
> > > 
> > > http://linus.bkbits.net:8080/linux-2.5/user=kai/cset@1.838.1.86?nav=!-|index.html|stats|!+|index.html|ChangeSet
> > 
> > OK, this is something else.
> > Making the shift to the extension .ko allowed the syntax:
> > make fs/ext2/ext2.ko or whatever module we want to build.
> > 
> > Thats very nice when developing on a module to speed up things.
> 
> Well, yes, but while installing into a final location all these .ko
> files could be renamed to have .o extensions.  This would avoid
> screwing up user-space utilities.  It is not that difficult to
> fix mkinitrd to try _both_ ways (I do not know how many folks runs
> exclusively 2.5 kernels) but who knows how many other things
> will have to be modified introducing gratituos incompatibilities.

I frankly doubt that avoiding breakage was considered in any way... So
much is changed without visible gain, I'm still trying to identify what
wonderful new capability was gained by doing the change at all.

That said, since the new stuff is different, the change of extension is
probably a good thing, since it clearly prevents someone from dropping a
2.4 module into the tree without a clue that things have changed. That's
not a problem, other than it breaking mkinitrd, a module utility still
notably missing from the module_init stuff.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

