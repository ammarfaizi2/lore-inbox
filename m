Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWFAIOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFAIOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFAIOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:14:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26557 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750788AbWFAIOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:14:54 -0400
Subject: Re: + big-kernel-lock-contention-in-do_open-and-blkdev_put.patch
	added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: kenneth.w.chen@intel.com, akpm@osdl.org
In-Reply-To: <200606010025.k510PPi3013738@shell0.pdx.osdl.net>
References: <200606010025.k510PPi3013738@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:14:51 +0200
Message-Id: <1149149691.3115.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Out of the 63 hits I see in 2.6.17-rc4 with
> block_device_operations->open(), floppy driver seems to be the only one
> that mucks around with a global Variable without any protection.  We can
> add a spin lock there.
> rg>
> ---
> 
>  fs/block_dev.c |    6 ------
>  1 file changed, 6 deletions(-)


the fix to floppy.c is missing!


(also I highly question the validity of this patch, last time the BKL
got dropped from open quite a few rootholes got opened... )

