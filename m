Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWHYONe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWHYONe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWHYONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:13:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13258 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751364AbWHYONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:13:32 -0400
Date: Fri, 25 Aug 2006 15:13:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] BLOCK: Don't call block_sync_page() from AFS [try #2]
Message-ID: <20060825141311.GF10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213303.21323.78091.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213303.21323.78091.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 67d6634..e1ba855 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -37,7 +37,7 @@ struct inode_operations afs_file_inode_o
>  
>  const struct address_space_operations afs_fs_aops = {
>  	.readpage	= afs_file_readpage,
> -	.sync_page	= block_sync_page,
> +//	.sync_page	= block_sync_page,

commenting out thing using // isn't very nice.  Either remove it completely
or use #if 0 with a normal /* */ that describes why it's not compiled.
