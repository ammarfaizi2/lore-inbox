Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265574AbSKAD2t>; Thu, 31 Oct 2002 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbSKAD2t>; Thu, 31 Oct 2002 22:28:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17404 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265574AbSKAD2s>;
	Thu, 31 Oct 2002 22:28:48 -0500
Date: Thu, 31 Oct 2002 22:35:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/11  Ext2/3 Updates: Extended attributes, ACL, etc.
In-Reply-To: <20021101032159.GA12031@think.thunk.org>
Message-ID: <Pine.GSO.4.21.0210312232390.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Theodore Ts'o wrote:

> I'm not sure ext2meta will be sufficient.  It's not just a matter of
> modifying the on-disk metadata, as would be needed for defrag, but I
> would also need to modify some of the in-core data structions in the
> ext2/3 filesystem data structures.  For example, when you resize the
> filesystem, you need to increase the number of group descriptors,
> which means you need to kmalloc, copy, and then kfree sbi->group_desc
> out from under the mounted filesystem.
> 
> No doubt ext2meta could be modified so it could "reach out and touch"
> internal ext2/3 fileststem data structures in core.  But the locking
> issues involved get really messy.

For all practical purposes, ext2meta is part of ext2 - same driver,
two filesystem types.  Locking isn't that scary, BTW - I'd looked
into that some time ago and it looked feasible.

