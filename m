Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTEXRu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTEXRu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 13:50:27 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262567AbTEXRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 13:50:26 -0400
Date: Sat, 24 May 2003 19:03:29 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make vt_ioctl ix86isms explicit
In-Reply-To: <Pine.LNX.4.44.0305241046590.10806-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0305241901250.27645-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > sys_ioperm is only implemented on x86 (i386/x86_64).  Make the
> > ifdefs in vt_ioctl.c more explicit so the other architectures can
> > get rid of their stubs in favour of just using sys_ni_syscall in
> > the syscall table.  (Personally I still wonder why they added it
> > at all but that's another question..)
> 
> They were added because this was how the X server got IO permissions a 
> million years ago.  It comes from some random old UNIX/386 thing, it 
> predates Linux itself as far as I know.
> 
> I'm fairly certain that X itself no longer uses it at all, but there may
> be other programs that still do (unlikely). Your patch looks sane,
> although it might be equally sane to just remove the code altogether.

I suggest we remove it. It was the old way to access the VGA register 
ports. 

