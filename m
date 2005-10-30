Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVJ3X2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVJ3X2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVJ3X2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:28:51 -0500
Received: from verein.lst.de ([213.95.11.210]:34179 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932404AbVJ3X2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:28:50 -0500
Date: Mon, 31 Oct 2005 00:28:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: xfs-masters@oss.sgi.com
Cc: nathans@sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] [2.6 patch] fs/xfs/: possible cleanups
Message-ID: <20051030232817.GA18053@lst.de>
References: <20051030200242.GK4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030200242.GK4180@stusta.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 09:02:42PM +0100, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global functions static
> - xfs_trans_item.c should #include "xfs_trans_priv.h" for getting the
>   prototypes of it's global functions.
> 
> Please review which of these changes do make sense.

I applied the things from your last patch that we could apply, but some
symbols can't be made static because the parts of codebase are shared with
userland and Linux 2.4 where they need to be global.  I'll go through
this patch again and will apply the parts that we can do - there seems
to be lots of new stuff vs last time.

