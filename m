Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVEPTXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVEPTXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVEPTT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:19:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261818AbVEPTS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:18:29 -0400
Date: Mon, 16 May 2005 21:18:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauriciolin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4-mm2: proc-pid-smaps.patch broke nommu
Message-ID: <20050516191827.GG5112@stusta.de>
References: <20050516021302.13bd285a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516021302.13bd285a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems proc-pid-smaps.patch is guilty for this nommu breakage in -mm:

<--  snip  -->

...
  LD      vmlinux
fs/built-in.o(.text+0x32b08): In function `smaps_open':
/usr/src/ctest/mm/kernel/fs/proc/base.c:560: undefined reference to `_proc_pid_smaps_op'
make[1]: *** [vmlinux] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

