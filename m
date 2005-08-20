Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVHTRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVHTRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVHTRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 13:36:09 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932591AbVHTRgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 13:36:08 -0400
Date: Sat, 20 Aug 2005 19:36:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Joel Becker <joel.becker@oracle.com>,
       Zach Brown <zach.brown@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>,
       Sunil Mushran <sunil.mushran@oracle.com>,
       Manish Singh <manish.singh@oracle.com>
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
Subject: 2.6.13-rc6-mm1: git-ocfs2.patch breaks jffs
Message-ID: <20050820173605.GV3615@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
>  git-ocfs2.patch
>...
>  Subsystem trees
>...

gcc correctly tells that at least a part of this patch incorrect (not 
that gcc says "is used", not "might be used"):

<--  snip  -->

...
  CC      fs/jffs/inode-v23.o
fs/jffs/inode-v23.c: In function 'jffs_create':
fs/jffs/inode-v23.c:1282: warning: 'inode' is used uninitialized in this function
...

<--  snip  -->

Looking at the code, it's trivial to verify that gcc is right.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

