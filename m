Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263318AbVGOPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbVGOPgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 11:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbVGOPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 11:36:38 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:37088 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S263318AbVGOPgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 11:36:35 -0400
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <1121440067.4137.2.camel@localhost.localdomain>
References: <1121346444.4282.8.camel@localhost.localdomain>
	 <200507151249.52294.agruen@suse.de>
	 <1121434894.1261.4.camel@localhost.localdomain>
	 <200507151636.27532.agruen@suse.de>
	 <1121440067.4137.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 00:30:19 +0900
Message-Id: <1121441419.4137.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005-07-16 (Sat) 00:07 +0900 Akinobu Mita wrote:
> Currently, mbcache is used only for xattr on ext2/ext3 and reiserfs.
> In other words, only one type of mbcache is used per-filesystem.
> So any problems don't happen without the patch I sent.
> 
> But, for example when someone use mbcache as another purpose on ext3,
> The crash will be caused by using mb_cache_shrink().
> 

The crash doesn't happen..
But, If more than two type of mbcache exist per-filesystem,
mb_cache_shrink() is not effective.

