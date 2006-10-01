Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWJARYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWJARYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWJARYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:24:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932070AbWJARYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:24:31 -0400
Subject: Re: [PATCH] MTD: fix printk warning
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       axboe@kernel.dk, rdunlap@xenotime.net
In-Reply-To: <20061001161600.GA7636@havoc.gtf.org>
References: <20061001161600.GA7636@havoc.gtf.org>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Oct 2006 18:23:17 +0100
Message-Id: <1159723397.3257.25.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 12:16 -0400, Jeff Garzik wrote:
> gcc spits out this warning:
> 
> drivers/mtd/mtd_blkdevs.c: In function ‘do_blktrans_request’:
> drivers/mtd/mtd_blkdevs.c:72: warning: format ‘%ld’ expects type ‘long int’, but argument 2 has type ‘unsigned int’

> -		printk(KERN_NOTICE "Unknown request %ld\n", rq_data_dir(req));
> +		printk(KERN_NOTICE "Unknown request %u\n", rq_data_dir(req));

Applied; thanks. I'd applied it once already and reverted it because it
seemed wrong -- but now the change which made it necessary is upstream.

-- 
dwmw2

