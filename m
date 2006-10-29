Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965403AbWJ2UTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbWJ2UTx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 15:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965409AbWJ2UTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 15:19:52 -0500
Received: from mx2.netapp.com ([216.240.18.37]:7776 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S965403AbWJ2UTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:19:51 -0500
X-IronPort-AV: i="4.09,369,1157353200"; 
   d="scan'208"; a="422612374:sNHT17446600"
Subject: Re: [PATCH] nfs: Fix nfs_readpages() error path
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
In-Reply-To: <20061029121613.4fbc5c74.akpm@osdl.org>
References: <877iyjundz.fsf@duaron.myhome.or.jp>
	 <1162149038.5545.37.camel@lade.trondhjem.org>
	 <20061029121613.4fbc5c74.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Sun, 29 Oct 2006 15:19:48 -0500
Message-Id: <1162153188.5545.59.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 29 Oct 2006 20:20:11.0853 (UTC) FILETIME=[A2EA37D0:01C6FB97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 12:16 -0800, Andrew Morton wrote:
> On Sun, 29 Oct 2006 14:10:38 -0500
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> 
> > Instead of the BUG_ON(), why can't we just stick a put_pages_list() into
> > __do_page_cache_readahead() and then get rid of all that duplicated
> > error handling in mpage_readpages(), nfs_readpages(), fuse_readpages(),
> > etc?
> 
> I don't recall anything which would prevent that from being done.  iirc it
> was one of those things which never happen.  Then things changed and it
> happened once and was hence a special case.  Then more things changed and
> it happened again, etc.

OK. I'll try to get round to doing it tomorrow (got to change to winter
tyres on my car today :-)).

Cheers,
  Trond
