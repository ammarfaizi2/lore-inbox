Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269019AbUHZPIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269019AbUHZPIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268976AbUHZPIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:08:05 -0400
Received: from mail.shareable.org ([81.29.64.88]:18886 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269020AbUHZPFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:05:44 -0400
Date: Thu, 26 Aug 2004 16:04:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christophe Saout <christophe@saout.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826150434.GF5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826140500.GA29965@fs.tum.de> <1093530313.11694.56.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093530313.11694.56.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> What reiser4 can do, but the VFS can't is to insert or remove data in
> the middle of a file. Adding this above the page cache would probably be
> almost impossible (truncate seems already complicated enough).

That would be one of those "special features" that a
VFS-plus-userspace implementation of archive views could take
advantage of on reiser4, while using a slower method (sometimes much
slower) on all other filesystems.

By the way, can reiser4 share parts of files between different files?

-- Jamie
