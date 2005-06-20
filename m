Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFTRig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFTRig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFTRif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:38:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261234AbVFTRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:38:33 -0400
Date: Mon, 20 Jun 2005 19:38:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Max Asbock <masbock@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Vernon Mauery <vernux@us.ibm.com>
Subject: 2.6.12-mm1: drivers/misc/ibmasm/ compile error
Message-ID: <20050620173831.GB3666@stusta.de>
References: <20050619233029.45dd66b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:30:29PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc6-mm1:
>...
> +ibmasm-driver-redesign-handling-of-remote-control.patch
>...
>  IBMASM driver updates
>...

"debug" is a bad name for a global variable:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.bss+0x5d468): multiple definition of `debug'
arch/i386/kernel/built-in.o(.text+0x2dc8): first defined here
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

