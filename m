Return-Path: <linux-kernel-owner+w=401wt.eu-S1751147AbXAQXP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXAQXP5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 18:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXAQXP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 18:15:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47914 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXAQXP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 18:15:57 -0500
Date: Wed, 17 Jan 2007 23:15:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] nfs: fix congestion control
Message-ID: <20070117231554.GC9387@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Trond Myklebust <trond.myklebust@fys.uio.no>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com> <20070116135325.3441f62b.akpm@osdl.org> <1168985323.5975.53.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168985323.5975.53.camel@lappy>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6-git.orig/fs/inode.c	2007-01-12 08:03:47.000000000 +0100
> +++ linux-2.6-git/fs/inode.c	2007-01-12 08:53:26.000000000 +0100
> @@ -81,6 +81,7 @@ static struct hlist_head *inode_hashtabl
>   * the i_state of an inode while it is in use..
>   */
>  DEFINE_SPINLOCK(inode_lock);
> +EXPORT_SYMBOL_GPL(inode_lock);

Btw, big "no fucking way" here.  There is no chance we're going to export
this, even _GPL
