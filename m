Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJQVuJ>; Thu, 17 Oct 2002 17:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262227AbSJQVuJ>; Thu, 17 Oct 2002 17:50:09 -0400
Received: from rj.SGI.COM ([192.82.208.96]:9880 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262230AbSJQVuI>;
	Thu, 17 Oct 2002 17:50:08 -0400
Date: Fri, 18 Oct 2002 07:55:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Add POSIX Access Control Lists to ext2/3
Message-ID: <20021018075555.B307856@wobbly.melbourne.sgi.com>
References: <E181a3b-0006Nu-00@snap.thunk.org> <20021016155012.GA8210@think.thunk.org> <20021017084836.B302869@wobbly.melbourne.sgi.com> <200210171204.08922.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210171204.08922.agruen@suse.de>; from agruen@suse.de on Thu, Oct 17, 2002 at 12:04:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 12:04:08PM +0200, Andreas Gruenbacher wrote:
> Hello Nathan,

hi there,

> On Thursday 17 October 2002 00:48, Nathan Scott wrote:
> > They are an optimisization for the one special case (posix acls),
> > and manage to pollute the VFS for that one special case ...
> ...
> As soon as any filesystem independent part of the kernel needs an interface 
> more efficient that pass-by-value we will again have exactly the same 
> problem.

My point is simply that a proposal to extend the VFS in this way needs
to be accompanied by a compelling argument showing the performance bump
that its providing.

> Going to disk and fetching EAs only causes disk accesses once; afterwards the 
> block is cached.

Good - this is true for both XFS and ext2/3 then.  So, we are talking about
using ref counting vs. copying for any in-kernel users of attrs, and you're
saying there is some significant overheads with copying and I'm saying show
me what kind of overheads we're talking about, please.

cheers.

-- 
Nathan
