Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJFNwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJFNwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:52:04 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:63127 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262099AbTJFNwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:52:00 -0400
Message-ID: <3F81744E.3080105@terra.com.br>
Date: Mon, 06 Oct 2003 10:55:26 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cciss-discuss@lists.sourceforge.net
Subject: Re: [PATCH] release_region in cciss block driver
References: <3F816DE5.8060009@terra.com.br> <20031006134225.GA972@suse.de>
In-Reply-To: <20031006134225.GA972@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000901090107070804000908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000901090107070804000908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jens Axboe wrote:
> Please at least try and follow the local style when you make changes.

	Right, sorry.

	Andrew, please use this patch instead.

Felipe


--------------000901090107070804000908
Content-Type: text/plain;
 name="cciss-region.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss-region.patch"

--- linux-2.6.0-test6/drivers/block/cciss.c.orig	2003-10-06 10:18:01.000000000 -0300
+++ linux-2.6.0-test6/drivers/block/cciss.c	2003-10-06 10:25:04.000000000 -0300
@@ -2185,6 +2185,7 @@
 		schedule_timeout(HZ / 10); /* wait 100ms */
 	}
 	if (scratchpad != CCISS_FIRMWARE_READY) {
+		release_io_mem(c);
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
 		return -1;
 	}

--------------000901090107070804000908--

