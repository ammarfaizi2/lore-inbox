Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292035AbSBYRfR>; Mon, 25 Feb 2002 12:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292908AbSBYRfI>; Mon, 25 Feb 2002 12:35:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1710 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292035AbSBYRfB>;
	Mon, 25 Feb 2002 12:35:01 -0500
Date: Mon, 25 Feb 2002 12:34:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Son of Unbork (1 of 3)
In-Reply-To: <Pine.GSO.4.21.0202251224150.3162-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0202251231290.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Alexander Viro wrote:

> On Sat, 23 Feb 2002, Daniel Phillips wrote:

> > Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
> Vetoed.

To elaborate: there is no reason why private stuff couldn't be allocated
by ext2_fill_super() and freed by ext2_put_super().  What's more, there
is no reason why it would break for any other fs.  IOW, new methods are
not necessary.  Now apply Occam's Razor.

