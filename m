Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWHYOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWHYOIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWHYOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:08:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64676 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932392AbWHYOIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:08:46 -0400
Date: Fri, 25 Aug 2006 15:08:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] BLOCK: Move functions out of buffer code [try #2]
Message-ID: <20060825140825.GB10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:32:53PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Move some functions out of the buffering code that aren't strictly buffering
> specific.  This is a precursor to being able to disable the block layer.
> 
>  (*) Moved some stuff out of fs/buffer.c:
> 
>      (*) The file sync and general sync stuff moved to fs/sync.c.
> 
>      (*) The superblock sync stuff moved to fs/super.c.
> 
>      (*) do_invalidatepage() moved to mm/truncate.c.
> 
>      (*) try_to_release_page() moved to mm/filemap.c.
> 
>  (*) Moved some related declarations between header files:
> 
>      (*) declarations for do_invalidatepage() and try_to_release_page() moved
>      	 to linux/mm.h.
> 
>      (*) __set_page_dirty_buffers() moved to linux/buffer_head.h.
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Please remove the CONFIG_BLOCK that splipped in and should only be in the
final patch.  Otherwise ACK.
