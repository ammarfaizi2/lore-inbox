Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbVIBAjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbVIBAjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 20:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030614AbVIBAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 20:39:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9488 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030613AbVIBAjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 20:39:17 -0400
Date: Fri, 2 Sep 2005 02:39:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Subject: RFC: i386: kill !4KSTACKS
Message-ID: <20050902003915.GI3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4Kb kernel stacks are the future on i386, and it seems the problems it
initially caused are now sorted out.

Does anyone knows about any currently unsolved problems?

I'd like to:
- get a patch into on of the next -mm kernels that unconditionally 
  enables 4KSTACKS
- if there won't be new reports of breakages, send a patch to
  completely remove !4KSTACKS for 2.6.15

In -mm, Reiser4 still has a dependency on !4KSTACKS.
I've mentioned this at least twice to the Reiser4 people, and they 
should check why this dependency is still there and if there are still 
stack issues in Reiser4 fix them.

If not people using Reiser4 on i386 will have to decide whether to 
switch the filesystem or the architecture...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

