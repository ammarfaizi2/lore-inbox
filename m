Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTBORtU>; Sat, 15 Feb 2003 12:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBORtU>; Sat, 15 Feb 2003 12:49:20 -0500
Received: from ns.suse.de ([213.95.15.193]:33540 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262871AbTBORtT> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 12:49:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Date: Sat, 15 Feb 2003 18:59:11 +0100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       "Theodore T'so" <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de> <20030215110732.A17564@infradead.org>
In-Reply-To: <20030215110732.A17564@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302151859.11370.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 February 2003 12:07, Christoph Hellwig wrote:
> On Tue, Feb 11, 2003 at 08:18:58PM +0100, Andreas Gruenbacher wrote:
> > The third to fifth are all steps towards trusted extended
> > attributes, which are useful for privileged processes (mostly
> > daemons). One use for this is Hierarchical Storage Management, in
> > which a user space daemon stores online/offline information for
> > files in trusted EA's, and the kernel communicates requests to
> > bring files online to that daemon. This class of EA's will also
> > find its way into XFS and ReiserFS, and expectedly also into JFS in
> > this form. (Trusted EAs are included in the 2.4.19/2.4.20 patches
> > as well.)
>
> Please don't do the ugly flags stuff.  We have fsuids and fsgids for
> exactly that reason (and because we're still lacking a credentials
> cache..).

The XATTR_KERNEL_CONTEXT flag cannot be substituted by a uid/gid change; 
it is unrelated to that; that's the whole point of it. It would be 
possible to raise some other flag (such as a capability, etc.) instead 
of passing an explicit flag, but that seems uglier and more 
problematic/error prone to me.

-- Andreas.

