Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUFAOze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUFAOze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFAOze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:55:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23264 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262175AbUFAOzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:55:22 -0400
Date: Tue, 1 Jun 2004 16:55:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2-mm1: gcc 2.95 uaccess.h warnings
Message-ID: <20040601145515.GC25681@fs.tum.de>
References: <20040601021539.413a7ad7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be Linus'

  sparse: make x86 user pointer checks stricter.

patch that causes the following warnings for every single file including 
uaccess.h when using gcc 2.95:

<--  snip  -->

...
In file included from include/linux/poll.h:11,
                 from include/linux/skbuff.h:28,
                 from include/linux/security.h:34,
                 from init/do_mounts.c:8:
include/asm/uaccess.h: In function `verify_area':
include/asm/uaccess.h:109: warning: dereferencing `void *' pointer
include/asm/uaccess.h: In function `__copy_from_user':
include/asm/uaccess.h:453: warning: dereferencing `void *' pointer
include/asm/uaccess.h:456: warning: dereferencing `void *' pointer
include/asm/uaccess.h:459: warning: dereferencing `void *' pointer
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

