Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUD0EDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUD0EDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUD0EDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:03:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:44163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263740AbUD0EDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:03:11 -0400
Date: Mon, 26 Apr 2004 21:02:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
Message-Id: <20040426210237.788045cf.akpm@osdl.org>
In-Reply-To: <408DD2D5.1040306@yahoo.com.au>
References: <20040426171856.22514.qmail@lwn.net>
	<20040426181235.2b5b62c8.akpm@osdl.org>
	<408DD2D5.1040306@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  Andrew Morton wrote:
> 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/slab-order-0-for-vfs-caches.patch
>  > 
>  > is not a completely happy solution, but it should fix things up.
> 
>  Another thing you could be doing is not zeroing swapper->nr
>  if the shrinker function doesn't do anything, in order to try
>  to maintain pressure on the dcache. This would be similar to
>  your deferred list idea.

Am now doing this.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/shrink_slab-handle-GFP_NOFS.patch
