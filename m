Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRFDAfY>; Sun, 3 Jun 2001 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbRFDAY1>; Sun, 3 Jun 2001 20:24:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64438 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263657AbRFDATA>;
	Sun, 3 Jun 2001 20:19:00 -0400
Date: Sun, 3 Jun 2001 20:18:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: mount --bind accounting
In-Reply-To: <UTC200106032038.WAA184171.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106032018090.29779-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> Something entirely different.
> 
> Last year I added the comment
> 	/* No capabilities? What if users do thousands of these? */
> in super.c for "mount --bind".
> Now that I do some polishing there I noticed the comment again.
> 
> Each bind does an alloc_vfsmnt() and hence takes some kernel memory.
> Any user can therefore take all kernel memory, until
> 	kmalloc(sizeof(struct vfsmount), GFP_KERNEL)
> fails. Bad security.
> I suppose something needs to be done about that.

Like looking at mount_is_safe(), maybe?

