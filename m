Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVFGV1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVFGV1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVFGV1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:27:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44561 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261988AbVFGV1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:27:08 -0400
Date: Tue, 7 Jun 2005 23:27:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Subject: RFC: i386: kill !4KSTACKS
Message-ID: <20050607212706.GB7962@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4Kb kernel stacks are the future on i386, and it seems the problems it 
initially caused are now sorted out.

I'd like to:
- get a patch into the next -mm that unconditionally enables 4KSTACKS
- if there won't be new reports of breakages, send a patch to
  completely remove !4KSTACKS for 2.6.13 or 2.6.14

The only drawback is that REISER4_FS does still depend on !4KSTACKS.
I told Hans back in March that this has to be changed.

Is there any ETA until that all issues with 4Kb kernel stacks in Reiser4 
will be resolved?

If not people using Reiser4 might have to decide whether to switch the 
filesystem or the architecture...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

