Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSAaAPP>; Wed, 30 Jan 2002 19:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290763AbSAaAPG>; Wed, 30 Jan 2002 19:15:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62705 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290765AbSAaAOx>;
	Wed, 30 Jan 2002 19:14:53 -0500
Date: Wed, 30 Jan 2002 19:14:52 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Kris Urquhart <kurquhart@littlefeet-inc.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
In-Reply-To: <20020130163730.N763@lynx.adilger.int>
Message-ID: <Pine.GSO.4.21.0201301912290.13602-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Jan 2002, Andreas Dilger wrote:

> On Jan 30, 2002  15:07 -0800, Kris Urquhart wrote:
> > [1.] One line summary of the problem: 
> > A mount of an already mounted ext2 partition corrupts inodes if there have
> > been recent writes without an intervening sync.
> 
> This _should_ be handled OK by the kernel simply by not mounting the
> filesystem the second time.  If you try and mount it a second time it
> _should_ just do a "bind" mount instead of a real mount, I think.

Which is what actually happens.  I suspect that he ends up forgetting to
umount it...

Anyway, try to reproduce it on 2.4.16 or later and give the contents of
/proc/mounts before and after your script.

