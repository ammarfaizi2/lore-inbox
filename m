Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUKGVn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUKGVn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUKGVn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 16:43:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7182 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261651AbUKGVnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 16:43:21 -0500
Date: Sun, 7 Nov 2004 22:42:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Harald Welte <laforge@netfilter.org>
Cc: linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-net@vger.kernel.org
Subject: 2.4.28-rc2: net/atm/proc.c compile error
Message-ID: <20041107214246.GY14308@stusta.de>
References: <20041107173753.GB30130@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107173753.GB30130@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 03:37:53PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.28-rc1 to v2.4.28-rc2
> ============================================
>...
> Harald Welte:
>   o [NET]: Backport neighbour scalability fixes from 2.6.x
>...


This patch removes atm_lec_info but not the user of this function, 
resulting in the following compile error:


<--  snip  -->

...
gcc-2.95 -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.28-rc2-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=proc  -c -o proc.o proc.c
proc.c: In function `atm_proc_init':
proc.c:624: `atm_lec_info' undeclared (first use in this function)
proc.c:624: (Each undeclared identifier is reported only once
proc.c:624: for each function it appears in.)
make[3]: *** [proc.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-rc2-full/net/atm'

<--  snip  -->

