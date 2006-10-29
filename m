Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965391AbWJ2UQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965391AbWJ2UQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbWJ2UQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:16:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965391AbWJ2UQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:16:17 -0500
Date: Sun, 29 Oct 2006 12:16:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
Message-Id: <20061029121613.4fbc5c74.akpm@osdl.org>
In-Reply-To: <1162149038.5545.37.camel@lade.trondhjem.org>
References: <877iyjundz.fsf@duaron.myhome.or.jp>
	<1162149038.5545.37.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 14:10:38 -0500
Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> Instead of the BUG_ON(), why can't we just stick a put_pages_list() into
> __do_page_cache_readahead() and then get rid of all that duplicated
> error handling in mpage_readpages(), nfs_readpages(), fuse_readpages(),
> etc?

I don't recall anything which would prevent that from being done.  iirc it
was one of those things which never happen.  Then things changed and it
happened once and was hence a special case.  Then more things changed and
it happened again, etc.
