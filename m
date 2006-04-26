Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWDZS6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWDZS6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWDZS6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:58:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43399 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964811AbWDZS6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:58:19 -0400
Date: Wed, 26 Apr 2006 19:58:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060426185813.GA26680@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426111054.2b4f1736.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:10:54AM -0700, Andrew Morton wrote:
> > But boy I wish find_get_pages_contig() was there
> > for that. I think I'd prefer adding that instead of coding that logic in
> > splice, it can get a little tricky.
> 
> I guess it'd make sense - we haven't had a need for such a thing before.
> 
> umm, something like...

XFS would have a use for it, too.  In fact XFS would prefer a
find_or_create_pages-like thing which is the thing splice wants in
the end aswell.

