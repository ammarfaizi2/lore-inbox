Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752076AbWCBXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbWCBXbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbWCBXbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:31:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752076AbWCBXbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:31:51 -0500
Date: Thu, 2 Mar 2006 15:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] reiserfs: reiserfs_file_write will lose error code when
 a 0-length write occurs w/ O_SYNC
Message-Id: <20060302153358.4cace15e.akpm@osdl.org>
In-Reply-To: <20060302210947.GA16696@locomotive.unixthugs.org>
References: <20060302210947.GA16696@locomotive.unixthugs.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Boy, lots of reiserfs things happening lately.

We presently have:

reiserfs-do-not-check-if-unsigned-0.patch	[ merged today ]
reiserfs-fix-transaction-overflowing.patch
reiserfs-handle-trans_id-overflow.patch
reiserfs-reiserfs_file_write-will-lose-error-code-when-a-0-length-write-occurs-w-o_sync.patch
reiserfs-cleanups.patch
reiserfs-use-balance_dirty_pages_ratelimited_nr-in-reiserfs_file_write.patch
reiserfs-fix-unaligned-bitmap-usage.patch

The question is, which of these are sufficiently serious-and-safe for
2.6.16?

I haven't seen any resierfs bug reports for quite some time (except for the
usual dribble of it-goes-oops-in-prints.c-when-something-went-wrong
reports).

So I'm inclined to hold off on all the above?
