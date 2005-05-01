Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVEAFIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVEAFIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEAFIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 01:08:47 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:43182 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261322AbVEAFIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 01:08:46 -0400
X-ORBL: [67.124.119.21]
Date: Sat, 30 Apr 2005 22:08:33 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050501050833.GA3045@taniwha.stupidest.org>
References: <20050425211915.126ddab5@jack.colino.net> <Pine.LNX.4.61.0504252145220.25129@scrub.home> <20050425220345.6b2ed6d5@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425220345.6b2ed6d5@jack.colino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:03:45PM +0200, Colin Leroy wrote:

>  cleanup:
>  	hfsplus_put_super(sb);
> +
> +cleanup_little:
>  	if (nls)
>  		unload_nls(nls);
> +	sb->s_fs_info = NULL;
> +	kfree(sbi);

cleanup_little?  why not cleanup_no_put or something?
