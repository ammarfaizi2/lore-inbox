Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbQLQK6B>; Sun, 17 Dec 2000 05:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132070AbQLQK5w>; Sun, 17 Dec 2000 05:57:52 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:21508 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131630AbQLQK5s>; Sun, 17 Dec 2000 05:57:48 -0500
Date: Sun, 17 Dec 2000 10:27:19 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2)
In-Reply-To: <20001216230701.E609@jaquet.dk>
Message-ID: <Pine.LNX.4.30.0012171024500.14423-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Rasmus Andersen wrote:

> Various files in drivers/mtd references cfi_probe (by way of do_cfi_probe).
> This function is static and thus not shared. The following patch removes
> the static declaration but if it is What Was Intended I do not know. It
> makes the kernel link, however.

It is intended, thanks. Not only does it make the inter_module_xxx case
work reliably, but it also allows you to compile the code at all under
2.0 uCLinux. The reason it was omitted from test12 is because there are a
handful of other changes to the CFI code which I haven't yet tested as
thoroughly as I want to. If you're using CFI flash, please could you test
the latest version from my CVS tree and let me know the results?


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
