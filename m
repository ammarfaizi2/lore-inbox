Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbREOUbs>; Tue, 15 May 2001 16:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbREOUbi>; Tue, 15 May 2001 16:31:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:21940 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261457AbREOUbe>;
	Tue, 15 May 2001 16:31:34 -0400
Date: Tue, 15 May 2001 16:31:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <3B0190F6.9D08D9CE@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151628340.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, H. Peter Anvin wrote:

> Alexander Viro wrote:
> > >
> > > What else could it be, since it's a "struct inode *"?  NULL?
> > 
> > struct block_device *, for one thing. We'll have to do that as soon
> > as we do block devices in pagecache.
> > 
> 
> How would you know what datatype it is?  A union?  Making "struct
> block_device *" a "struct inode *" in a nonmounted filesystem?  In a
> devfs?  (Seriously.  Being able to do these kinds of data-structural
> equivalence is IMO the nice thing about devfs & co...)

void *.

Look, methods of your address_space certainly know what they hell they
are dealing with. Just as autofs_root_readdir() knows what inode->u.generic_ip
really points to.

Anybody else has no business to care about the contents of ->host.

