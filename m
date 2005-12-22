Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVLVXa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVLVXa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVLVXa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:30:57 -0500
Received: from pat.uio.no ([129.240.130.16]:20695 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030373AbVLVXa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:30:57 -0500
Subject: Re: nfs invalidates lose pte dirty bits
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051222175550.GT9576@opteron.random>
References: <20051222175550.GT9576@opteron.random>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 18:30:49 -0500
Message-Id: <1135294250.3685.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.117, required 12,
	autolearn=disabled, AWL 0.83, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 18:55 +0100, Andrea Arcangeli wrote:
> Hello Andrew,
> 
> this is yet another problem exposed by the new invalidate_inode_pages2
> semantics.
> 
> If a mapping has dirty data (pte dirty and page clean), and an
> invalidate triggers, the filemap_write_and_wait will do nothing, but the
> invalidate_inode_pages2 will destroy the pte dirty bit and discard the
> pagecache.

See the latest git release where we introduce the nfs_sync_mapping()
helper.

Cheers,
  Trond

