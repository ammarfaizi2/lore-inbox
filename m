Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSIWSlb>; Mon, 23 Sep 2002 14:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSIWSlb>; Mon, 23 Sep 2002 14:41:31 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261304AbSIWSl0>;
	Mon, 23 Sep 2002 14:41:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.17258.990642.379366@charged.uio.no>
Date: Mon, 23 Sep 2002 18:38:02 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Daniel Phillips <phillips@arcor.de>, trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D811A6C.C73FEC37@digeo.com>
References: <3D811363.70ABB50C@digeo.com>
	<Pine.LNX.4.44L.0209121926310.1857-100000@imladris.surriel.com>
	<3D811A6C.C73FEC37@digeo.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > Look, idunnoigiveup.  Like scsi and USB, NFS is a black hole
     > where akpms fear to tread.  I think I'll sulk until someone
     > explains why this work has to be performed in the context of a
     > process which cannot do it.

I'd be happy to move that work out of the RPC callbacks if you could
point out which other processes actually can do it.

The main problem is that the VFS/MM has no way of relabelling pages as
being invalid or no longer up to date: I once proposed simply clearing
PG_uptodate on those pages which cannot be cleared by
invalidate_inode_pages(), but this was not to Linus' taste.

Cheers,
  Trond
