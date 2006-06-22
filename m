Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbWFVC44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbWFVC44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWFVC44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:56:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61155 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030547AbWFVC44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:56:56 -0400
Date: Thu, 22 Jun 2006 12:56:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Message-ID: <20060622125640.C1135236@wobbly.melbourne.sgi.com>
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> <20060620161006.C1079661@wobbly.melbourne.sgi.com> <3aa654a40606192338v751150fp5645d1d2943316ea@mail.gmail.com> <20060620164338.A1080488@wobbly.melbourne.sgi.com> <3aa654a40606192350w5c469670t466dfc1344e23a4@mail.gmail.com> <20060620165209.C1080488@wobbly.melbourne.sgi.com> <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3aa654a40606200120v5baf0304ka205f1ad8f136ad9@mail.gmail.com>; from avuton@gmail.com on Tue, Jun 20, 2006 at 01:20:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:20:39AM -0700, Avuton Olrich wrote:
> On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
> > No - its in CVS (for a long time); I'll go get the ftp area updated,
> > looks like thats been forgotten about again.

FWIW, I've updated the ftp area now.

> OK, just compiled from CVS HEAD (xfs_repair 2.8.2) and it still fails:

Is this a large filesystem?  Any chance we can get access to
it somehow (e.g. xfs_copy to a sparse file, then send me a
pointer to it) to reproduce the problem locally?

> fatal error -- can't read block 16777216 for directory inode
> 1507133580

Once you save a copy of it for further analysis of xfs_repair,
if you can, you can clear out this problem by directly poking at
the device using xfs_db in expert mode.  "xfs_db -x /dev/xxx";
then "inode 1507133580"; then "write core.mode 0"; and then try
another xfs_repair run.  Please try capture the fs for us first
though (if possible) else we're going to struggle to improve on
this aspect of xfs_repair.  Send me some private mail if you do
manage to grab the fs and put it someplace for me.

thanks.

-- 
Nathan
