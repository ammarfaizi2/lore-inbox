Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTLDBYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTLDBYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:24:36 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:50950 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262844AbTLDBYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:24:25 -0500
Date: Wed, 3 Dec 2003 17:24:20 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031204012420.GE4420@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz> <bql9kk$iq1$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bql9kk$iq1$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:22:12PM +0000, bill davidsen wrote:
> In article <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>,
> Tomas Konir  <moje@vabo.cz> wrote:
> | On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
> | 
> | > Em Tue, Dec 02, 2003 at 02:38:54PM -0500, Tomas Konir escreveu:
> | > > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
> | > > 
> | > > > Em Tue, Dec 02, 2003 at 02:06:34PM -0500, Tomas Konir escreveu:
> | > > > > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
> | > > > > 
> | > > > > > Em Tue, Dec 02, 2003 at 12:54:36PM +0100, Ionut Georgescu escreveu:
> | > > > > > > I can only second that. We've been using XFS here since the days of
> | > > > > > > 2.4.0-testxx and the only problems we've had were sitting between the
> | > > > > > > chair and the keyboard.
> | > > > > > 
> | > > > > > So if there is no problems at all using it as a patch why add this to a
> | > > > > > kernel that is phasing out?
> | > > > > 
> | > > > > Because me and others are wasting our time when merging xfs with other 
> | > > > > patches such as grsecurity. XFS in kernel can save our time. The question 
> | > > > > is, that if JFS and other FS's are in kernel, why not XFS ?
> | > > > 
> | > > > Why not ReiserFS4? Or DRBD? Or... :-)
> | > > 
> | > > ReiserFS4 is stable ? very new information for me.
> 
> Therein is a fair question. There are a lot more people using XFS than
> JFS, or at least if people are using JFS they are not talking about it

Perhaps because we aren't having many problems with it.

> much. And XFS has been around and stable for a long time, probably
> longer than stable JFS (and some would argue Reiser ;-). I don't think
> new FS should be added indefinitely, but since XFS has seniority, a
> larger user base than some FS in the kernel, neither of which will ever
> be argued again for another FS, it seems possible to add XFS without
> setting foot on some hypothetical slippery slope.

Probably more to the point is that not only is XFS used by
many but has been part of distro kernels for some time.

> As a stability issue, since people are using XFS, it would probably be
> better to have it in than as a patch added and possibly modified by each
> vendor.

The fewer patches, particularly feature patches the distros
have to add the less painful it would be to try a different
kernel or change distros.

That said, if XFS is wanted in Linux it should become a
Linux native and not be dependant on IRIX APIs just so SGI
engineers can use an unmodified common codebase.  I agree
wholeheartedly with Marcello on that point.

<OT>
As a datapoint i'm running ext2, reiserfs, JFS and XFS each
for different reasons.

	ext2 -- boot (i'm stodgy) and 2kb blocks for archive CDs

	reiserfs3 -- filesystems not exported nfs (no
	historical version level that i can confirm whether
	i have or not will namesys assert is reliable over
	nfs)

	jfs -- most nfs exported filesystems, decent
	performance and solid but i don't use if for home
	because in SuSE's 2.4.18 (i know it is ancient but
	solid for me) jfs doesn't update mtime of
	directories unless the block allocation changes
	breaking maildir update detection.

	xfs -- home (because of the jfs bug) Earlier tests
	of xfs gave me horrible performance and i haven't
	gotten around to testing since then.  If this is
	fixed without tuning i might drop jfs.  Then again i
	may drop xfs in the next upgrade if i change distros
	and xfs isn't in-kernel.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
