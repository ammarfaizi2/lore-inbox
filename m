Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278696AbRJSXzw>; Fri, 19 Oct 2001 19:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278697AbRJSXzn>; Fri, 19 Oct 2001 19:55:43 -0400
Received: from asooo.flowerfire.com ([63.254.226.247]:59660 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S278696AbRJSXza>; Fri, 19 Oct 2001 19:55:30 -0400
Date: Fri, 19 Oct 2001 18:56:03 -0500
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Cc: David Ford <david@blue-labs.org>
Subject: Re: [compile bug] 2.4.13-pre4 | i2o_pci.c:165 structure has no member named `pdev'
Message-ID: <20011019185603.A13465@asooo.flowerfire.com>
In-Reply-To: <3BCF44C2.5030504@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BCF44C2.5030504@blue-labs.org>; from david@blue-labs.org on Thu, Oct 18, 2001 at 05:08:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this has been an issue since -pre1 -- we've seen this too
with i2o as a module.  Between .11 and the parport issue with .12, it's
certainly been interesting recently. :)

Anyone have any news on this?  Sorry if I've missed it.

Thanks much,
-- 
Ken.
brownfld@irridia.com

On Thu, Oct 18, 2001 at 05:08:18PM -0400, David Ford wrote:
| Kernel 2.4.13-pre4
| 
| make[3]: Entering directory `/usr/local/src/linux/drivers/message/i2o'
| gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall 
| -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
| -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
| -march=i586    -DEXPORT_SYMTAB -c i2o_pci.c
| i2o_pci.c: In function `i2o_pci_install':
| i2o_pci.c:165: structure has no member named `pdev'
| 
| ...
|    c->bus.pci.irq = -1;
|    c->bus.pci.queue_buggy = 0;
|    c->bus.pci.dpt = 0;
|    c->bus.pci.short_req = 0;
|    c->bus.pci.pdev = dev;
| 
| Has someone already fixed this before I start digging?
| 
| David
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
