Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEEBBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEEBBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUEEBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 21:01:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:64191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261206AbUEEBBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 21:01:18 -0400
Date: Tue, 4 May 2004 18:03:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of
 mapped pages
Message-Id: <20040504180345.099926ec.akpm@osdl.org>
In-Reply-To: <20040505002029.11785.qmail@web12821.mail.yahoo.com>
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> Presently the kernel does not collection information
> about the percentage of memory that processes have
> dirtied via mmap until reclamation.  Nothing analogous
> to balance_dirty_pages() is being done for mmap'ed
> pages.  The attached patch adds collection of dirty
> page information during kswapd() scans and initiation
> of background writeback by waking up bdflush.

And what were the effects of this patch?

Did you consider propagating the pte dirtiness into the pageframe within
page_referenced(), while we're there?
