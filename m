Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUBQUlv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUBQUjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:39:22 -0500
Received: from mail.shareable.org ([81.29.64.88]:3717 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266533AbUBQUi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:38:27 -0500
Date: Tue, 17 Feb 2004 20:38:16 +0000
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217203816.GD24311@mail.shareable.org>
References: <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> So what you are saying is that conversion of invalid multibyte sequences
> into non-error wide chars followed by conversion back into UTF-8 can
> lead to trouble?  *DUH*

Yes.  (The point being that it's a common bug, just like buffer
overflows are common.  Rejecting malformed UTF-8 is a defensive
strategy against it).

> > The holes only arise because software which is interpreting UTF-8 is
> > mixed with software which isn't.  That's one of the most useful
> > features of UTF-8, after all - that's why we use it for filenames.
> 
> The holes only arise because software which is interpreting UTF-8 doesn't
> care to do it properly.

That's right.  Software which does it properly rejects malformed UTF-8.
That is the entire point of my post.

> Software that doesn't interpret it (including the kernel) doesn't
> enter the picture at all.

Yes.

Your posting merely repeated what I said, so I assume we're in agreement :)

-- Jamie
