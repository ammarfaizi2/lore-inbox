Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUK2XLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUK2XLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUK2XJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:09:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64776 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261856AbUK2XEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:04:30 -0500
Subject: Re: [2.6 patch] select for drivers/mtd
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041128225616.GG4390@stusta.de>
References: <20041128225616.GG4390@stusta.de>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 23:04:15 +0000
Message-Id: <1101769455.6960.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 23:56 +0100, Adrian Bunk wrote:
> The patch below switches options to use select where appropriate.

Thanks. Applied to bk://linux-mtd.bkbits.net/mtd-2.6 to go in after
2.6.10

> One of the dependencies of MTD_GEN_PROBE was on MTD_INTELPROBE that
> isn't in Linus' tree. If this symbol is present in the mtd cvs, a
> similar select is needed there.

It's gone now; removing it was correct.

> What's the purpose of the MTD_DOCECC option, which has always the same 
> value as the MTD_DOCPROBE option?

It's obsolescent. The new DiskOnChip hardware driver was recently
converted from using it, in favour of the new Reed-Solomon library code.
Some day relatively soon the old hardware driver can go too, but not
yet. It's probably not worth converting that to the new ECC code.

-- 
dwmw2

