Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264935AbTFVS13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTFVS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:27:29 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:7194 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264935AbTFVS13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:27:29 -0400
Date: Sun, 22 Jun 2003 11:41:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page cache readahead implemented?
Message-Id: <20030622114159.1ebbc236.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0306221922110.5241-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306221922110.5241-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 18:41:33.0993 (UTC) FILETIME=[E790B190:01C338ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> do_mmap_pgoff's PROT_EXEC do_page_cache_readahead assumes that is
>  implemented for all mappings, but not all filesystems provide ->readpage.

Which filesystems?

For tmpfs and other memory-backed filesystems we could perhaps just
rely on backing_dev_info.ra_pages being zero.  For others, maybe
we should just say "thou shalt implement readpage".
