Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWDJSfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWDJSfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWDJSfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:35:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8464 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932097AbWDJSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:35:23 -0400
Date: Mon, 10 Apr 2006 20:35:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] CONFIGFS_FS must depend on SYSFS
Message-ID: <20060410183522.GE2408@stusta.de>
References: <20060326122552.GM4053@stusta.de> <20060327030622.GV7844@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327030622.GV7844@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 07:06:22PM -0800, Joel Becker wrote:
> On Sun, Mar 26, 2006 at 02:25:52PM +0200, Adrian Bunk wrote:
> > This patch fixes the following compile error with CONFIG_SYSFS=n:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > fs/built-in.o: In function `configfs_init':mount.c:(.init.text+0x3d5d): undefined reference to `kernel_subsys'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> 	Hmm.  We only rely on SYSFS because of the policy decree of
> default mounting at /sys/kernel/config (just like GregKH was asked to
> put debugfs at /sys/kernel/debug).  While we create the mount point, we
> don't rely on it.  You can mount configfs anywhere you like.
> 	So, what do you think of making that part of the code check for
> CONFIG_SYSFS?  Then the module can be built without SYSFS instead of
> depending on it.  I'm open to either idea.  Certainly, we don't leave
> the compile error.

First of all sorry for the late answer.

My intention is to get the compile error fixed, and I don't care that 
much how it gets fixed.

OTOH, there's the question whether it matters at all - is the 
intersection of the people who are in such space-limited environments 
that they are setting CONFIG_EMBEDDED=y and then CONFIG_SYSFS=n and
the people using OCFS2 actually non-empty?

> Joel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

