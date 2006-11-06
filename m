Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753908AbWKFXFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbWKFXFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbWKFXFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:05:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753908AbWKFXFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:05:49 -0500
Date: Mon, 6 Nov 2006 23:05:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Message-ID: <20061106230547.GA29711@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Tso <tytso@mit.edu>
References: <454FAE0A.3070409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454FAE0A.3070409@redhat.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 03:50:02PM -0600, Eric Sandeen wrote:
> so I would propose the following patch to make PAGE_CACHE_SIZE the default (again), 
> and let filesystems which need something -else- do that on their own.

I agree with the conclusion, but the patch is incomplete.  You went down
all the way to find out what the fileystems do in this messages, so add
the hunks to override the defaults for non-standard filesystems to the
patch aswell to restore the pre-inode diet state.

