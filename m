Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTE2Ign (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTE2Ign
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:36:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:55721 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262015AbTE2Igm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:36:42 -0400
Date: Thu, 29 May 2003 01:49:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Message-Id: <20030529014959.757871fa.akpm@digeo.com>
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
References: <20030529012914.2c315dad.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 08:49:59.0620 (UTC) FILETIME=[495B3040:01C325BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm2/

urgh, sorry.  It has some extra debug which will generate a storm of
warnings with ext2.  Delete the below line.


diff -puN mm/page_alloc.c~x mm/page_alloc.c
--- 25/mm/page_alloc.c~x	2003-05-29 01:48:25.000000000 -0700
+++ 25-akpm/mm/page_alloc.c	2003-05-29 01:48:29.000000000 -0700
@@ -256,7 +256,6 @@ static inline void free_pages_check(cons
 			1 << PG_locked	|
 			1 << PG_active	|
 			1 << PG_reclaim	|
-			1 << PG_checked	|
 			1 << PG_writeback )))
 		bad_page(function, page);
 	if (PageDirty(page))

_

