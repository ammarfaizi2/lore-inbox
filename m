Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVBRUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVBRUSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVBRUSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:18:52 -0500
Received: from soundwarez.org ([217.160.171.123]:58859 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261497AbVBRURT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:17:19 -0500
Date: Fri, 18 Feb 2005 21:17:13 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, david@fubar.dk
Subject: Re: [PATCH] add I/O error uevent for block devices
Message-ID: <20050218201713.GA9084@vrfy.org>
References: <20050218083316.GA6619@vrfy.org> <20050218014621.0b453232.akpm@osdl.org> <20050218124503.GA7705@vrfy.org> <20050218110232.6512f0fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218110232.6512f0fb.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 11:02:32AM -0800, Andrew Morton wrote:
> Kay Sievers <kay.sievers@vrfy.org> wrote:
> >
> >  > - there are numerous other places where an I/O error can be detected:
> >  >   grep the tree for b_end_io and bio_end_io.
> > 
> >  You mean the mmap and direct-io stuff?
> 
> direct-io, certainly.  Also reiserfs, xfs, ntfs, ext3, jfs and possibly md
> have their own I/O completion handlers.

Hmm, ok. Any idea how to propagate errors like this in a saner way? Some of
these places don't even log errors and spreading uevents all over the place
doesn't sounds like the best idea.

Thanks,
Kay
