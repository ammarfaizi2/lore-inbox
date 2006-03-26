Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWCZMat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWCZMat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCZMat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:30:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29479 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751307AbWCZMas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:30:48 -0500
Date: Sun, 26 Mar 2006 14:27:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] BLK_DEV_IO_TRACE Kconfig fixes
Message-ID: <20060326122743.GF4290@suse.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060326122540.GL4053@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326122540.GL4053@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26 2006, Adrian Bunk wrote:
> On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc6-mm2:
> >...
> >  git-blktrace.patch
> >...
> >  git trees.
> >...
> 
> BLK_DEV_IO_TRACE breaks the rule "If you select something, you must 
> endure that the dependencies of what you are select'ing are fulfilled."
> resulting in the following compile error with CONFIG_SYSFS=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> fs/built-in.o: In function `debugfs_init':inode.c:(.init.text+0x3d35): 
> undefined reference to `kernel_subsys'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> This patch fixes this bug.
> 
> Additionally, it moves the BLK_DEV_IO_TRACE option that now depends on 
> DEBUG_KERNEL into the menu with the other DEBUG_KERNEL options.

Thanks for the sysfs fix, however don't move the kconfig entry, this
isn't a debug option.

-- 
Jens Axboe

