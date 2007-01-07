Return-Path: <linux-kernel-owner+w=401wt.eu-S965236AbXAGWsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbXAGWsX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbXAGWsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:48:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54288 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965236AbXAGWsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:48:22 -0500
Date: Sun, 7 Jan 2007 14:48:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Sami Farin <7atbggg02@sneakemail.com>,
       Nathan Scott <nathans@sgi.com>, xfs@oss.sgi.com,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-Id: <20070107144812.96357ff9.akpm@osdl.org>
In-Reply-To: <20070107222341.GT33919298@melbourne.sgi.com>
References: <20070106023907.GA7766@m.safari.iki.fi>
	<Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com>
	<20070107222341.GT33919298@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 09:23:41 +1100
David Chinner <dgc@sgi.com> wrote:

> How are you supposed to invalidate a range of pages in a mapping for
> this case, then? invalidate_mapping_pages() would appear to be the
> candidate (the generic code uses this), but it _skips_ pages that
> are already mapped.

unmap_mapping_range()?

> So, am I correct in assuming we should be calling invalidate_inode_pages2_range()
> instead of truncate_inode_pages()?

That would be conventional.
