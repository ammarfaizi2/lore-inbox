Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLBLeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 06:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLBLeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 06:34:07 -0500
Received: from intra.cyclades.com ([64.186.161.6]:65448 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261799AbTLBLeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 06:34:02 -0500
Date: Tue, 2 Dec 2003 09:18:26 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Nathan Scott <nathans@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
In-Reply-To: <20031201221058.GA621@frodo>
Message-ID: <Pine.LNX.4.44.0312020858320.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Nathan Scott wrote:

> On Mon, Dec 01, 2003 at 12:06:14PM -0200, Marcelo Tosatti wrote:
> > On Mon, 1 Dec 2003, Nathan Scott wrote:
> > 
> > > Hi Marcelo,
> > > 
> > > Please do a
> > > 
> > > 	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> > > 
> > > This will merge the core 2.4 kernel changes required for supporting
> > > the XFS filesystem, as listed below.  If this all looks acceptable,
> > > then please also pull the filesystem-specific code (fs/xfs/*)
> > > 
> > > 	bk pull http://xfs.org:8090/linux-2.4+justXFS
> > 
> > Nathan, 
> > 
> > I think XFS should be a 2.6 only feature.
> > 
> > 2.6 is already stable enough for people to use it. 
> > 
> 
> Hi Marcelo,
> 
> Please reconsider -- the "core" kernel changes we need have existed
> for three+ years outside of the mainline tree, and each is a small
> and easily understood change that doesn't affect other filesystems.
> There is also a VFS fix in there from Ethan Benson, as we discussed
> during 2.4.23-pre, when you asked us to resend XFS for 2.4.24-pre!)
> Everything there is a backport from 2.6 in some form, there should
> be no surprises.

Nathan,

I remember I have said to you "resend me XFS for 2.4.24-pre". A changed my 
mind since then...

> Not having XFS in 2.4 is extremely disadvantageous for us XFS folks
> (especially since every other journaled filesystem has been merged
> now).  

JFS did not touch generic code as I remember.

> To our users it means some rescue disks simply don't support
> XFS, meaning you can't mount filesystems when you _really_ need to,
> etc, etc.  Its also always extra work for distributors to merge XFS
> themselves, and hence a few just don't (and occasionally tell us
> that they are waiting for you to merge it) - which means some users
> don't even get the option of using XFS, despite our best efforts.

Come one, it is not so hard to maintain a patch in a distros kernel.  

Distros maintain hundreds of patches (even I did maintain hundreds of
patches while maintaining Conectiva's RPM). One more patch is not that
hard.

> From discussions with distributors, a stable 2.6 distribution will
> be many months after 2.6.0 is officially released, so these issues
> are not going to go away anytime soon.

Fine, so people who want XFS go compile 2.6.0 by hand. I'm using test11 on
several boxes and its working very well.

And 2.6 is much nicer than 2.4 anyway.

> So, please merge XFS this time round - its actively developed, has
> a large installed user base, and has been maintained outside of 2.4
> for a long time.  We have waited patiently as each release goes by
> for you to give us the nod, and have been knocked back on a number
> of occasions while various other merges are being done.

Also I'm not completly sure if the generic changes are fine and I dont
like the XFS code in general.



