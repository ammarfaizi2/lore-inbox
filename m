Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWHDFqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWHDFqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWHDFpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:45:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030345AbWHDFp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:45:26 -0400
Date: Thu, 3 Aug 2006 22:45:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: nate.diller@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Message-Id: <20060803224519.dd9bf38e.akpm@osdl.org>
In-Reply-To: <20060804052031.GA4717@suse.de>
References: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
	<20060804052031.GA4717@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 07:20:32 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Aug 03 2006, Nate Diller wrote:
> > the Elevator iosched would prefer to be unconditionally notified of a
> > merge, but the current API calls only one 'merge' notifier
> > (elv_merge_requests or elv_merged_requests), even if both front and
> > back merges happened.
> > 
> > elv_extended_request satisfies this requirement in conjunction with
> > elv_merge_requests.
> 
> Ok, I suppose. But please rebase patches against the 'block' git branch,
> there are extensive changes in this area.
> 

argh, the great (but partial ;)) renaming bites again.

A suitable patch to merge against is
http://www.zip.com.au/~akpm/linux/patches/stuff/git-block.patch
