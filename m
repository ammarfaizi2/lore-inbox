Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269635AbUHZVXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269635AbUHZVXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269641AbUHZVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:09:26 -0400
Received: from mail.shareable.org ([81.29.64.88]:12999 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269642AbUHZVAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:00:47 -0400
Date: Thu, 26 Aug 2004 22:00:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Will Dyson <will_dyson@pobox.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826210027.GD5733@mail.shareable.org>
References: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <20040826100530.GA20805@taniwha.stupidest.org> <20040826110258.GC30449@mail.shareable.org> <412E06B2.7060106@pobox.com> <1093552705.5678.96.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093552705.5678.96.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Same here.  This always seemed like something the kernel should be able
> to handle.  It seems to me that if reiser4 had been available at the
> time the Gnome and KDE developers would not have needed to do this.

reiser4 has prompted the discussion again, but it doesn't provide the
virtual filesystem capabilities that we're talking about, which Gnome
and KDE implement in userspace.  The FUSE project is much more
relevant for that.

We had file-as-directory discussions years ago, and 5 years ago I was
experimenting with doing virtual filesystems with that capability over NFS.

podfuk offered something close to Gnome and KDE but in kernel space:
virtual filesytems accessible through the kernel, but it didn't get
too popular.  It was based on Midnight Commander's VFS (which has
evolved into Gnome's VFS), using the CODA filesystem interface to
provide the kernel hooks.  It had some problems, and was a bit fiddly
to use.  We still don't have something that's particularly nice to use
for ordinary users.

-- Jamie
