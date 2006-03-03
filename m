Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWCCRbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWCCRbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCCRbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:31:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55256 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751019AbWCCRbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:31:21 -0500
Message-ID: <44087D67.2000104@namesys.com>
Date: Fri, 03 Mar 2006 09:31:19 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Mahoney <jeffm@suse.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] reiserfs: reiserfs_file_write will lose error code when
 a 0-length write occurs w/ O_SYNC
References: <20060302210947.GA16696@locomotive.unixthugs.org> <20060302153358.4cace15e.akpm@osdl.org>
In-Reply-To: <20060302153358.4cace15e.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Boy, lots of reiserfs things happening lately.
>
>We presently have:
>
>reiserfs-do-not-check-if-unsigned-0.patch	[ merged today ]
>reiserfs-fix-transaction-overflowing.patch
>reiserfs-handle-trans_id-overflow.patch
>reiserfs-reiserfs_file_write-will-lose-error-code-when-a-0-length-write-occurs-w-o_sync.patch
>reiserfs-cleanups.patch
>reiserfs-use-balance_dirty_pages_ratelimited_nr-in-reiserfs_file_write.patch
>reiserfs-fix-unaligned-bitmap-usage.patch
>
>The question is, which of these are sufficiently serious-and-safe for
>2.6.16?
>
>I haven't seen any resierfs bug reports for quite some time (except for the
>usual dribble of it-goes-oops-in-prints.c-when-something-went-wrong
>reports).
>
>So I'm inclined to hold off on all the above?
>
>
>  
>
I suggest that they sit in -mm or an rc for ~2 weeks before they go in. 
If 2.6.16 is coming out before then, then let it ship without them.  All
of these things are pretty obscure/rare, so not unsettling the code
matters more than getting them in.
