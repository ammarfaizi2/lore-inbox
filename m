Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVE2O0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVE2O0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVE2O0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:26:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20233 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261324AbVE2O0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:26:20 -0400
Date: Sun, 29 May 2005 16:26:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1: fork connector doesn't compile with gcc 2.95
Message-ID: <20050529142619.GA5764@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following compile breakage with gcc 2.95 is caused by 
fork-connector-send-status-to-userspace.patch:

<--  snip  -->

...
  CC      drivers/connector/cn_fork.o
In file included from drivers/connector/cn_fork.c:36:
include/linux/cn_fork.h:58: warning: unnamed struct/union that defines 
no instances
include/linux/cn_fork.h:60: warning: unnamed struct/union that defines 
no instances
drivers/connector/cn_fork.c: In function `fork_connector':
drivers/connector/cn_fork.c:75: structure has no member named `ppid'
drivers/connector/cn_fork.c:76: structure has no member named `ptid'
drivers/connector/cn_fork.c:77: structure has no member named `cpid'
drivers/connector/cn_fork.c:78: structure has no member named `ctid'
drivers/connector/cn_fork.c: In function `cn_fork_send_status':
drivers/connector/cn_fork.c:110: structure has no member named `status'
make[2]: *** [drivers/connector/cn_fork.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

