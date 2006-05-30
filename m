Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWE3Fwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWE3Fwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWE3Fwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:52:41 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44455 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932132AbWE3Fwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:52:40 -0400
Date: Tue, 30 May 2006 01:51:15 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       mike@halcrow.us, ezk@cs.sunysb.edu
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060530055115.GD18626@filer.fsl.cs.sunysb.edu>
References: <447AC011.8050708@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447AC011.8050708@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 07:34:09PM +1000, Nick Piggin wrote:
...
> Can we get rid of the whole thing, confusing memory barriers and all?
> Nobody uses anything but the default sync_page

I feel like I must say this: there are some file systems that live
outside the kernel (at least for now) that do _NOT_ use the default
sync_page. All the stackable file systems that are based on FiST [1],
such as Unionfs [2] and eCryptfs (currently in -mm) [3] (respective
authors CC'd). As an example, Unionfs must decide which lower file
system page to sync (since it may have several to chose from).

Josef "Jeff" Sipek.

[1] http://www.filesystems.org
[2] http://unionfs.filesystems.org
[3] http://ecryptfs.sourceforge.net


