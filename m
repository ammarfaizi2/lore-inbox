Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310483AbSCRFJp>; Mon, 18 Mar 2002 00:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310501AbSCRFJf>; Mon, 18 Mar 2002 00:09:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22510
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310483AbSCRFJ0>; Mon, 18 Mar 2002 00:09:26 -0500
Date: Sun, 17 Mar 2002 21:10:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Theodore Tso <tytso@mit.edu>, David Rees <dbr@greenhydrant.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020318051046.GD2254@matchmail.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com> <20020313133748.A12472@greenhydrant.com> <20020313215420.GD429@turbolinux.com> <20020315182355.A1123@thunk.org> <20020317072653.GB1150@turbolinux.com> <20020317183752.GB27249@matchmail.com> <20020318030317.GC1150@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 08:03:17PM -0700, Andreas Dilger wrote:
> On Mar 17, 2002  10:37 -0800, Mike Fedyk wrote:
> > On Sun, Mar 17, 2002 at 12:26:53AM -0700, Andreas Dilger wrote:
> > > Yes, I have always considered this a kernel bug (introduced in 2.4.10),
> > > but my (admittedly feeble) attempts to get it fixed were not accepted.
> > > At one point I thought a fix went into 2.4.18-pre[12] or so, but I
> > > guess not.  I haven't tried in a while, so maybe I should make another
> > > attempt.
> > > 
> > 
> > Was that part of the 2.4.10-pre11 -aa VM merge, or was it from another
> > seperate patch?
> 
> Well, at the same time as Linus merged -aa VM, he also merged
> blockdev-in-pagecache from -aa.  This caused this problem, among others.

Ahh yes, I remember now.

> With blockdev-in-pagecache, the kernel thinks block device access is the
> same as reading a file, so it imposes file limits.  It also caused the

Right.

> problem that the block device (pagecache) and the filesystem (buffer
> cache) were not coherent, causing e2fsck, tune2fs, etc to not work.
> 

This was fixed in 2.4.12 I believe.

I also heard one offhand remark that similar problems have crept back
into the kernel recently.  Is that true?
