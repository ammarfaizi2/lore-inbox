Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269709AbRHCXmF>; Fri, 3 Aug 2001 19:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269708AbRHCXly>; Fri, 3 Aug 2001 19:41:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37847 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269707AbRHCXlh>;
	Fri, 3 Aug 2001 19:41:37 -0400
Date: Fri, 3 Aug 2001 19:41:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804113525.E17925@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031937120.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> On Fri, Aug 03, 2001 at 07:25:19PM -0400, Alexander Viro wrote:
> 
>     You need credentials to sync a regular file on any network
>     filesystem.
> 
> For 2.5.x I assume your planning or a credentials cache?  Something
> like dentry->d_creds or something?  If that's the case we still don't
> need the struct file* to be passed --- but I suspect that's not the
> case and I really don't understand.

file->f_cred. Different people opening the same file can have different
credentials (e.g. credentials can be revoked)

