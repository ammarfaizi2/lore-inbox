Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263989AbUDQAJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUDQAJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:09:58 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:62127 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263989AbUDQAJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:09:56 -0400
Subject: Re: [PATCH 2.6.5] Add class support to drivers/mtd/mtdchar.c
From: David Woodhouse <dwmw2@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <221630000.1082154920@w-hlinder.beaverton.ibm.com>
References: <207270000.1082063407@w-hlinder.beaverton.ibm.com>
	 <1082063698.2949.6.camel@localhost.localdomain>
	 <221630000.1082154920@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1082160598.3083.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1.dwmw2.1) 
Date: Fri, 16 Apr 2004 20:09:58 -0400
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 15:35 -0700, Hanna Linder wrote:
> Thanks David. I tried the MTDRAM and it showed up in the class tree but
> no dev file was made. I suspect it needs a device attached. Anyway, I found
> a small bug by code inspection so here is the new patch.

MTDRAM is a fake MTD device, using backing store provided by vmalloc().
There is no hardware. If you have mtdram.ko and mtdchar.ko both loaded,
you should have been able to access /dev/mtd0 and you should have seen
it in /proc/mtd

-- 
dwmw2

