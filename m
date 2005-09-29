Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVI2XCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVI2XCV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVI2XCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:02:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:41695 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751332AbVI2XCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:02:20 -0400
Date: Fri, 30 Sep 2005 01:02:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Deepak Saxena <dsaxena@plexity.net>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix IXP4xx MTD driver no cast warning
Message-ID: <20050929230222.GA30887@wohnheim.fh-wedel.de>
References: <20050929195205.GA30002@plexity.net> <Pine.LNX.4.58.0509291259110.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0509291259110.3308@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 September 2005 13:00:18 -0700, Linus Torvalds wrote:
> On Thu, 29 Sep 2005, Deepak Saxena wrote:
> > 
> > drivers/mtd/maps/ixp4xx.c: In function 'ixp4xx_flash_probe':
> > drivers/mtd/maps/ixp4xx.c:199: warning: assignment makes integer from
> > pointer without a cast
> 
> Please don't. The warning is entirely warranted, as far as I can tell.
> 
> Shutting up warnings just because they are warnings is bad practice. 
> Either fix them, or leave them be.
> 
> If you do an "ioremap()", then the result is a "(void __iomem *)". If you 
> assign it to something that is "unsigned long", you _should_ get a 
> warning.

Code is correct, as far as this specific mapping driver is concerned.
But it would make some sense to convert one of the map_priv_[12] in
struct map_info to (void __iomem *).

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius
