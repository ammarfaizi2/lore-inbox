Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbTE1OY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbTE1OY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:24:56 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:11005 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S264746AbTE1OYz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:24:55 -0400
Date: Wed, 28 May 2003 15:39:15 +0200
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Subject: [Patch][2.4] Oops if limit of memory via 'mem=123' failed.
Message-ID: <20030528133915.GA1578@zodiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the following patch would have saved me some time in wondering about the
'mem=XXX' kernel-parameter (more specific that initrd failed if mem=XXX is
greater than the available physical memory size).
Please apply if you think it would be helpful to other.
 Peter

--- linux-2.4.20/arch/i386/kernel/setup.c_orig  2003-05-28
12:57:39.000000000 +0200
+++ linux-2.4.20/arch/i386/kernel/setup.c       2003-05-28
13:07:21.000000000 +0200
@@ -433,6 +433,7 @@
                        }
                }
        }
+       printk(KERN_ERR "Ooops! Limit of memory to %016Lx failed!\n", size);
 }
 static void __init add_memory_region(unsigned long long start,
                                   unsigned long long size, int type)


