Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTIPR5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTIPR5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:57:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36818 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261996AbTIPR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:57:00 -0400
Date: Tue, 16 Sep 2003 19:56:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mac@melware.de, info@melware.de
Cc: kkeil@suse.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: 2.6: ISDN_DIVAS link error: multiple "errno"
Message-ID: <20030916175653.GD17690@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following link error in 2.6.0-test5-mm2 (it desn't seem to be
specific to -mm) with CONFIG_ISDN_DIVAS=y :

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.bss+0x123d60): multiple definition of `errno'
lib/lib.a(errno.o)(.bss+0x0): first defined here

<--  snip  -->


drivers/isdn/hardware/eicon/divasmain.c has a non-static variable errno
(on a first sight it doesn't seem to be really used) that conflicts
with the variable in lib/errno.c .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

