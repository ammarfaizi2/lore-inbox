Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265053AbSJPPPQ>; Wed, 16 Oct 2002 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265055AbSJPPPQ>; Wed, 16 Oct 2002 11:15:16 -0400
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:64776 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265053AbSJPPPP>; Wed, 16 Oct 2002 11:15:15 -0400
Date: Wed, 16 Oct 2002 16:20:47 +0100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021016152047.GA11422@fib011235813.fsnet.co.uk>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAD75AE.7010405@pobox.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 10:20:30AM -0400, Jeff Garzik wrote:
> AFAIK Linus and Al Viro (and myself <g>) have always considered ioctls 
> an ugly -ism that should have never made it into Unix.

I'm not going to argue with you there.

> ioctl(2) is a pain for people like David Miller who must maintain
> 32<->64 bit ioctl translation layers for their architecture.

I know, the patch already includes ioctl32.c support for parisc,
sparc64, s390x, ppc64 and mips64.

> We now have libfs.c in 2.5.x that makes ramfs-based filesystems even 
> more tiny, too.  With the added flexibility of an fs -- it makes the 
> userland tools much more simple and sane -- and the pain of ioctls, it 
> seems a clear choice for new interfaces.

Yes, I was looking at libfs this morning and think it would remove a
lot of the code from our old fs interface.  Is this going to be
backported to 2.4 so that we can move to an fs interface there too ?

The driver has been designed to support different user interfaces, and
userland is isolated by way of the little libdevmapper library.  So
writing another another interface will be comparitively simple.  We
will do this.  However, I want this to be a seperate piece of work
from the current dm, I see no reason to stall inclusion of dm for
this.

- Joe
