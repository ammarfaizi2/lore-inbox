Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbQLQKcM>; Sun, 17 Dec 2000 05:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131180AbQLQKcD>; Sun, 17 Dec 2000 05:32:03 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:20996 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130552AbQLQKbx>; Sun, 17 Dec 2000 05:31:53 -0500
Date: Sun, 17 Dec 2000 10:01:07 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Rasmus Andersen <rasmus@jaquet.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: <27504.977008553@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0012170959580.14423-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000, Keith Owens wrote:

> Somebody changed include/linux/mtd/map.h between 2.4.0-test11 and
> test12.  That change is wrong, it adds conditional complexity where it
> is not required - inter_module_xxx works even without CONFIG_MODULES.
> cfi_probe should still be static.

No. Think about the link order. inter_module_xxx doesn't work reliably.
get_module_symbol() did.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
