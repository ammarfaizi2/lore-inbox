Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVKWBcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVKWBcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVKWBcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:32:50 -0500
Received: from colin.muc.de ([193.149.48.1]:59146 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030306AbVKWBcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:32:50 -0500
Date: 23 Nov 2005 02:32:44 +0100
Date: Wed, 23 Nov 2005 02:32:44 +0100
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, jeffrey.hundstad@mnsu.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
Message-ID: <20051123013244.GA3585@muc.de>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu> <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org> <20051122170507.37ebbc0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122170507.37ebbc0c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 05:05:07PM -0800, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Tue, 22 Nov 2005, Andrew Morton wrote:
> > 
> > > Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
> > > >
> > > >                 from fs/compat_ioctl.c:52,
> > > >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
> > > > include/linux/ext3_fs.h: In function 'ext3_raw_inode':
> > > > include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type
> > > 
> > > This might help?
> 
> The patch didn't help.
> 
> > 
> > Why does it happen at all, though?
> 
> davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
> That required inclusion of ext3 and jbd header files.  Those files explode
> unpleasantly when CONFIG_JBD=n.

Or use ->compat_ioctl and do it in fs/ext3

> 
> No trivial fix was apparent - perhaps we should disable the compat wrappers
> if CONFIG_EXT3=n and/or CONFIG_JBD=n.

That's already done for a lot of other wrappers, so would be fine too

-Andi
