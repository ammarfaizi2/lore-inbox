Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUC2Upy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUC2Upy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:45:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:23939 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbUC2Upx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:45:53 -0500
Date: Mon, 29 Mar 2004 12:48:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.5-rc2-aa5
Message-Id: <20040329124803.072bb7c6.akpm@osdl.org>
In-Reply-To: <20040329150646.GA3808@dualathlon.random>
References: <20040329150646.GA3808@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> Notably there is a BUG_ON(page->mapping) triggering in
> page_remove_rmap in the pagecache case. that could be ex-pagecache being
> removed from pagecache before all ptes have been zapped, infact the
> page_remove_rmap triggers in the vmtruncate path.

Confused.  vmtruncate zaps the ptes before removing pages from pagecache,
so I'd expect a non-null ->mapping in page_remove_rmap() is a very common
thing.  truncate a file which someone has mmapped and it'll happen every
time, will it not?

