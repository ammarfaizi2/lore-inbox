Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVGSAFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVGSAFy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 20:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGSAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 20:05:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50703 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261208AbVGSAFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 20:05:52 -0400
Date: Tue, 19 Jul 2005 02:05:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: johnpol@2ka.mipt.ru
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: drivers/w1/w1_int.c compile error with NET=n
Message-ID: <20050719000549.GD5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following compile error in 2.6.13-rc3-mm1 (but it doesn't 
seem to be specific to -mm) with CONFIG_NET=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `w1_alloc_dev':
w1_int.c:(.text+0x65d81f): undefined reference to `netlink_kernel_create'
w1_int.c:(.text+0x65d881): undefined reference to `sock_release'
drivers/built-in.o: In function `w1_free_dev':
w1_int.c:(.text+0x65d8e9): undefined reference to `sock_release'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


