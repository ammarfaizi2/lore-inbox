Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWIANvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWIANvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWIANvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:51:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2821 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751499AbWIANvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:51:01 -0400
Date: Fri, 1 Sep 2006 15:50:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Wilson <grant.wilson@zen.co.uk>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com
Subject: [-mm patch] drivers/md/Kconfig: fix BLOCK dependency
Message-ID: <20060901135055.GA18276@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org> <44F80F0D.70100@zen.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F80F0D.70100@zen.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:44:29AM +0100, Grant Wilson wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
> [snip]
> >  The CONFIG_BLOCK changes wrecked these.
> 
> The CONFIG_BLOCK changes also seem to prevent the selection of any RAID
> or LVM drivers...

Thanks for the bug report, patch below.

> Cheers,
> Grant

cu
Adrian


<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/drivers/md/Kconfig.old	2006-09-01 15:47:10.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/md/Kconfig	2006-09-01 15:47:16.000000000 +0200
@@ -2,7 +2,7 @@
 # Block device driver configuration
 #
 
-if CONFIG_BLOCK
+if BLOCK
 
 menu "Multi-device support (RAID and LVM)"
 

