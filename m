Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUIHVlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUIHVlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269161AbUIHVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:41:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29667 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269164AbUIHVk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:40:58 -0400
Date: Thu, 9 Sep 2004 07:40:47 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040909074046.A3958243@wobbly.melbourne.sgi.com>
References: <20040908123524.GZ390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040908123524.GZ390@unthought.net>; from jakob@unthought.net on Wed, Sep 08, 2004 at 02:35:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Wed, Sep 08, 2004 at 02:35:24PM +0200, Jakob Oestergaard wrote:
> 
> First XFS bug:
> ---------------
> http://oss.sgi.com/bugzilla/show_bug.cgi?id=309
> 
> Submitted in februrary this year - requires server reboot, NFS clients
> will then re-trigger the bug immediately after the NFS server is started
> again.  Clearly not a pleasent problem.
> 
> A fairly simple patch is available, which solves the problem in the most
> common cases.  This simple patch has *not*yet* been included in 2.6.8.1.
> 

Have you asked Christoph if he thinks that patch is ready for
inclusion?  Its possibly just fallen through the cracks.

> Second XFS bug:
> ---------------
> Also causes the 'kernel BUG at fs/xfs/support/debug.c:106' message to be
> printed. This bug is not solved by applying the simple patch to the
> first problem.
> 
> How well known this problem is, I don't know - I can get more details on
> this if anyone is actually interested in working on fixing XFS.

Yes please (it does help to actually contact the maintainers when
reporting bugs...).  It is not well known.

> Third XFS bug:
> --------------
> XFS causes lowmem oom, triggering the OOM killer. Reported by
> as@cohaesio.com on the 18th of august.
> 
> On the 24th of august, William Lee Irwin gives some suggestions and
> mentions  "xfs has some known bad slab behavior."

Hmm?  Which message was that?

> ...
> While the small server seems to be running well now, the large one has
> an average uptime of about one day (!)   Backups will crash it reliably,
> when XFS doesn't OOM the box at random.

It would be a good idea to track the memory statistics while you're
running your workloads to see where in particular the memory is being
used when you hit OOM - /proc/{meminfo,slabinfo,buddyinfo}.  I'd also
be interested to hear if that vfs_cache_pressure tweak that someone
recommended helps your load at all, thanks.

Is this xfsdump you're running for backups?

> Is anyone actually maintaining/bugfixing XFS?

Yes, there's a group of people actively working on it.

> Yes, I know the MAINTAINERS file,

But haven't figured out how to use it yet?

> ...
> trivial-to-trigger bugs that crash the system and have simple fixes,
> have not been fixed in current mainline kernels.

If you have trivial-to-trigger bugs (or other bugs) then please let
the folks at linux-xfs@oss.sgi.com know all the details (test cases,
etc, are quite useful).

cheers.

-- 
Nathan
