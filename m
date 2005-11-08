Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVKHK7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVKHK7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 05:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVKHK7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 05:59:46 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:10919 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751286AbVKHK7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 05:59:45 -0500
Date: Tue, 8 Nov 2005 11:59:24 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
Message-ID: <20051108105923.GA31446@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 November 2005 17:26:56 +0100, Arnd Bergmann wrote:
> 
> The MTD ioctls are all specific to mtdchar.c, so the
> compat code for them should be there as well.
> 
> Also, some of the ioctl commands used in that driver
> were previously not marked as compatible.
> 
> The conversion handlers could be further simplified
> by not using compat_alloc_user_space any more.
> 
> CC: dwmw2@infradead.org
> CC: linux-mtd@lists.infradead.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jörn Engel <joern@wh.fh-wedel.de>

Moving crap over to mtdchar.c is a good thing.  Complete removal of
mtdchar.c might be even better, but at least the crap is relatively
self-contained now.

Jörn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
