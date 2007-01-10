Return-Path: <linux-kernel-owner+w=401wt.eu-S965242AbXAJXVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbXAJXVu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXAJXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:21:50 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50373 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965239AbXAJXVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:21:49 -0500
Date: Wed, 10 Jan 2007 18:20:54 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Kara <jack@suse.cz>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070110232054.GB5088@filer.fsl.cs.sunysb.edu>
References: <20070109122644.GB1260@atrey.karlin.mff.cuni.cz> <200701091734.l09HYRHB009290@agora.fsl.cs.sunysb.edu> <20070110161215.GB12654@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070110161215.GB12654@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 05:12:15PM +0100, Jan Kara wrote:
>   I see :). To me it just sounds as if you want to do remount-read-only
> for source filesystems, which is operation we support perfectly fine,
> and after that create union mount. But I agree you cannot do quite that
> since you need to have write access later from your union mount. So
> maybe it's not so easy as I thought.
>   On the other hand, there was some effort to support read-only bind-mounts of
> read-write filesystems (there were even some patches floating around but
> I don't think they got merged) and that should be even closer to what
> you'd need...

Since the RO flag is per-mount point, how do you guarantee that no one is
messing with the fs? (I haven't looked at the patches that do per mount
ro flag, but this would require some over-arching ro flag - in the
superblock most likely.)

Josef "Jeff" Sipek.

-- 
I think there is a world market for maybe five computers.
		- Thomas Watson, chairman of IBM, 1943.
