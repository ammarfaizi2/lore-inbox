Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTLAWLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLAWLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:11:54 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:45120 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264137AbTLAWLv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:11:51 -0500
Date: Tue, 2 Dec 2003 09:10:58 +1100
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-ID: <20031201221058.GA621@frodo>
References: <20031201062052.GA2022@frodo> <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.44.0312011202330.13692-100000@logos.cnet>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 12:06:14PM -0200, Marcelo Tosatti wrote:
> On Mon, 1 Dec 2003, Nathan Scott wrote:
> 
> > Hi Marcelo,
> > 
> > Please do a
> > 
> > 	bk pull http://xfs.org:8090/linux-2.4+coreXFS
> > 
> > This will merge the core 2.4 kernel changes required for supporting
> > the XFS filesystem, as listed below.  If this all looks acceptable,
> > then please also pull the filesystem-specific code (fs/xfs/*)
> > 
> > 	bk pull http://xfs.org:8090/linux-2.4+justXFS
> 
> Nathan, 
> 
> I think XFS should be a 2.6 only feature.
> 
> 2.6 is already stable enough for people to use it. 
> 

Hi Marcelo,

Please reconsider -- the "core" kernel changes we need have existed
for three+ years outside of the mainline tree, and each is a small
and easily understood change that doesn't affect other filesystems.
There is also a VFS fix in there from Ethan Benson, as we discussed
during 2.4.23-pre, when you asked us to resend XFS for 2.4.24-pre!)
Everything there is a backport from 2.6 in some form, there should
be no surprises.

Not having XFS in 2.4 is extremely disadvantageous for us XFS folks
(especially since every other journaled filesystem has been merged
now).  To our users it means some rescue disks simply don't support
XFS, meaning you can't mount filesystems when you _really_ need to,
etc, etc.  Its also always extra work for distributors to merge XFS
themselves, and hence a few just don't (and occasionally tell us
that they are waiting for you to merge it) - which means some users
don't even get the option of using XFS, despite our best efforts.

>From discussions with distributors, a stable 2.6 distribution will
be many months after 2.6.0 is officially released, so these issues
are not going to go away anytime soon.

So, please merge XFS this time round - its actively developed, has
a large installed user base, and has been maintained outside of 2.4
for a long time.  We have waited patiently as each release goes by
for you to give us the nod, and have been knocked back on a number
of occasions while various other merges are being done.

cheers.

-- 
Nathan
