Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWFOHCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFOHCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFOHCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:02:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5296 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750786AbWFOHCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:02:04 -0400
Date: Thu, 15 Jun 2006 17:01:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Theodore Tso <tytso@mit.edu>, Nikita Danilov <nikita@clusterfs.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060615170136.D898607@wobbly.melbourne.sgi.com>
References: <20060613143230.A867599@wobbly.melbourne.sgi.com> <448EC51B.6040404@argo.co.il> <20060614084155.C888012@wobbly.melbourne.sgi.com> <17551.58643.704359.815153@gargle.gargle.HOWL> <20060615075018.B884384@wobbly.melbourne.sgi.com> <20060615054931.GC7318@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060615054931.GC7318@thunk.org>; from tytso@mit.edu on Thu, Jun 15, 2006 at 01:49:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Thu, Jun 15, 2006 at 01:49:31AM -0400, Theodore Tso wrote:
> On Thu, Jun 15, 2006 at 07:50:19AM +1000, Nathan Scott wrote:
> > As to whether a new inode operation is useful/needed - *shrug* - not
> > really my call, I was saying we can work with whatever ends up being
> > the final solution, provided it keeps per-inode granularity.
> 
> XFS should be return a per-inode value for st_blksize by simply setting
> kstat->st_blksize in linvfs_getattr() found in fs/xfs/linux-2.6/xfs_iops.c.

Hmm, you're looking at an older kernel there I guess - that routine
doesn't exist anymore.  Look at -mm, its the most recent version.

> in the Irix/Linux compatibility layer (yuck, I still can't believe
> this got into mainline),

There is no IRIX/Linux compatibility layer, you're misunderstanding
the code (which is understandable, its erm a bit crufty in places).
There's a fair bit of history there too - *shrug* - its on the improve
but its a complex body of code and takes time to mutate.  We've tended
to focus on real problems and needed features in the past, moreso than
cosmetics, but thats getting attention nowadays too.

> I'll let the XFS maintainers decide how put in per-inode st_blksize
> values --- but it is definitely doable.

Yep, agreed.

cheers.

-- 
Nathan
