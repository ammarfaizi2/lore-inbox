Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292846AbSCRUh1>; Mon, 18 Mar 2002 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSCRUhN>; Mon, 18 Mar 2002 15:37:13 -0500
Received: from zok.SGI.COM ([204.94.215.101]:39607 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292840AbSCRUhC>;
	Mon, 18 Mar 2002 15:37:02 -0500
Date: Tue, 19 Mar 2002 07:36:37 +1100
From: Nathan Scott <nathans@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre3-ac1 - Quotactl patch
Message-ID: <20020319073637.N1601@wobbly.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.40.0203180152260.21632-100000@coredump.sh0n.net> <E16mvRV-0004pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> > Right, but which old patch 2.4.18-pre3-quotactl reversed against

I assume you mean "2.4.18-pre3-ac2-quotactl.patch" from XFS CVS...
this was an incremental patch against Alan's tree, as described in
cmd/xfsmisc/README in the XFS CVS tree - it's not the right one to
be using here, since we're trying to back out the quota changes in
Alan's patches (a.k.a. Jan Kara's 32 bit uid/gid quota patches, at
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/)

> > 2.4.19-pre3-ac1 doesnt go out cleanly without patch complaining about
> > unreversed patch problems.

You would need to use the quota patch which is part of Alan's patches
in order to get back to the base kernel quota, before applying Jan's
new patches (which are patches against Linus'/Marcelo's kernels).  

Alan Cox wrote:
> It isnt a single patch, its patches with further fixes on top.

So, I'm starting to think the patch you need doesn't exist, Shawn...
Previously I thought Alan simply used Jan's quota patches directly,
but from what Alan's saying it sounds like that isn't correct and he
has additional fixes which aren't in Jan's patches. (?)

Anyway, I imagine you would still get most of the way there by reverse
applying Jan's patch (quota-patch-2.4.17-3.diff in XFS CVS) and then
fixing up any remaining issues by hand.  You just need to get back to
the base kernel quota as a starting point, because that's what Jan's
"alpha" patches are against (we use these in the XFS CVS tree now).

cheers.

-- 
Nathan
