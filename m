Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSEURxu>; Tue, 21 May 2002 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEURxt>; Tue, 21 May 2002 13:53:49 -0400
Received: from imladris.infradead.org ([194.205.184.45]:38417 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315334AbSEURxs>; Tue, 21 May 2002 13:53:48 -0400
Date: Tue, 21 May 2002 18:53:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffermem_pages removal (5/5)
Message-ID: <20020521185340.A694@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020521141015.E15796@infradead.org> <3CEA8917.7A52176C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 10:51:19AM -0700, Andrew Morton wrote:
> The buffermem_pages accounting is vaguely interesting because
> it tells us how much of ZONE_NORMAL is being usefully used for
> blockdev pagecache.  And ZONE_NORMAL utilisation is a bit of a
> hot topic at present.

Yho sais all blockdev mapping have to stay ZONE_NORMAL?  If filesystems
access them without buffer_heads there is no reason to not put the
pages in high memory.  I also remember vaguely that you intend to move
buffer_heads to high memory in the longer term..

> But the same information can be obtained on-demand by running
> around the bdev superblock's inodes adding up nr_pages.  That
> approach is better than the per-page atomic ops in buffer.c.

*nod*
