Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCBM7i>; Fri, 2 Mar 2001 07:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRCBM73>; Fri, 2 Mar 2001 07:59:29 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:47289 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129078AbRCBM7P>;
	Fri, 2 Mar 2001 07:59:15 -0500
Date: Fri, 2 Mar 2001 13:58:53 +0100
From: David Weinehall <tao@acc.umu.se>
To: Pavel Machek <pavel@suse.cz>
Cc: Alexander Viro <viro@math.psu.edu>, "H. Peter Anvin" <hpa@transmeta.com>,
        Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
Message-ID: <20010302135853.F22985@khan.acc.umu.se>
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com> <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu> <20010302100410.I15061@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010302100410.I15061@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Fri, Mar 02, 2001 at 10:04:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 10:04:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > >         * userland issues (what, you thought that limits on the
> > > > command size will go away?)
> > > 
> > > Last I checked, the command line size limit wasn't a userland issue, but
> > > rather a limit of the kernel exec().  This might have changed.
> > 
> > I _really_ don't want to trust the ability of shell to deal with long
> > command lines. I also don't like the failure modes with history expansion
> > causing OOM, etc.
> > 
> > AFAICS right now we hit the kernel limit first, but I really doubt that
> > raising said limit is a good idea.
> 
> I am running with 2MB limit right now. I doubt 2MB will lead to OOM.

You know, with a box with 4MB of RAM (or indeed 2MB, which should still
be possible on a Linux-system), a 2MB command-line is a very effective
DoS :^)

> > xargs is there for purpose...
> 
> xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
> . -name "12*" | xargs rm, which has terrible issues with files names
> 
> "xyzzy"
> "bla"
> "xyzzy bla"
> "12 xyzzy bla"
> 
> !
> 
> I do not want to deal with xargs. Xargs was made to workaround
> limitation at command line size (and is broken in itself). Now we have
> hardware that can handle bigger commandlines just fine, xargs should
> be killed.

/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
