Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVE2Oid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVE2Oid (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVE2Oid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:38:33 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261327AbVE2Oi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:38:28 -0400
Date: Sun, 29 May 2005 16:38:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1: drivers/char/tpm/ compile errors with gcc 2.95
Message-ID: <20050529143814.GA10441@stusta.de>
References: <20050525134933.5c22234a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems it's fix-tpm-driver-sysfs-owernship-changes.patch that causes 
the following compile errors with gcc 2.95:

<--  snip  -->

...
  CC      drivers/char/tpm/tpm_nsc.o
drivers/char/tpm/tpm_nsc.c:231: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_nsc.c:232: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_nsc.c:233: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_nsc.c:234: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_nsc.c:254: unknown field `fops' specified in initializer
drivers/char/tpm/tpm_nsc.c:254: warning: missing braces around initializer
drivers/char/tpm/tpm_nsc.c:254: warning: (near initialization for `tpm_nsc.miscdev')
drivers/char/tpm/tpm_nsc.c:254: warning: initialization makes integer from pointer without a cast
make[3]: *** [drivers/char/tpm/tpm_nsc.o] Error 1

<--  snip  -->

...
  CC      drivers/char/tpm/tpm_atmel.o
drivers/char/tpm/tpm_atmel.c:130: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_atmel.c:131: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_atmel.c:132: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_atmel.c:133: warning: initialization from incompatible pointer type
drivers/char/tpm/tpm_atmel.c:153: unknown field `fops' specified in initializer
drivers/char/tpm/tpm_atmel.c:153: warning: missing braces around initializer
drivers/char/tpm/tpm_atmel.c:153: warning: (near initialization for `tpm_atmel.miscdev')
drivers/char/tpm/tpm_atmel.c:153: warning: initialization makes integer from pointer without a cast
make[3]: *** [drivers/char/tpm/tpm_atmel.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

