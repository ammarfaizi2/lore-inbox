Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTEJQSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTEJQSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:18:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27127 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264430AbTEJQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:18:09 -0400
Date: Sat, 10 May 2003 18:30:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove all #include <blk.h>'s
Message-ID: <20030510163043.GJ1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch (gzipped due to 100 kB linux-kernel limit) removes 
all #include <blk.h>'s for 2.5 and blk.h does now #error. If people 
want their drivers to run unmodified under 2.4 it might be necessary to 
do a
  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,70)
  #include <linux/blk.h>
  #endif

I've tested the compilation in 2.5.69-bk4 with a .config that tries to
compile as much drivers as possible.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

