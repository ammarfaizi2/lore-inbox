Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUIVLWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUIVLWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIVLWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:22:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37639 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S264377AbUIVLWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:22:33 -0400
Date: Wed, 22 Sep 2004 13:21:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: 2.6.9-rc2-kjt1 rio_linux compile error
Message-ID: <20040922112157.GB27364@fs.tum.de>
References: <20040921221307.GG4260@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921221307.GG4260@stro.at>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 12:13:07AM +0200, maximilian attems wrote:
>...
> added since 2.6.9-rc1-kjt1
>...
> msleep-drivers_char_rio_linux.patch
>   From: Nishanth Aravamudan <nacc@us.ibm.com>
>   Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 20/33] char/rio_linux: replace 	schedule_timeout() with msleep()/msleep_interruptible()
>...

This doesn't compile (obvious typo):

<--  snip  -->

...
  CC      drivers/char/rio/rio_linux.o
drivers/char/rio/rio_linux.c: In function `RIODelay':
drivers/char/rio/rio_linux.c:333: warning: implicit declaration of function `jiffes_to_msecs'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x141239): In function `RIODelay':
: undefined reference to `jiffes_to_msecs'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

