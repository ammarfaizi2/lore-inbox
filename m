Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVCHA1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVCHA1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVCHA06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:26:58 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:25038 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261994AbVCHAZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:25:35 -0500
Date: Mon, 7 Mar 2005 16:25:27 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: Re: [Ext2-devel] Re: [CHECKER] crash after fsync causing serious FS
 corruptions (ext2, 2.6.11)
In-Reply-To: <20050307232221.GJ27352@schnapps.adilger.int>
Message-ID: <Pine.GSO.4.44.0503071614170.8295-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot Andreas.  Your message clarifies everything.

> In ext3 this case is handled because the filesystem won't reallocate the
> metadata blocks freed from file A before they have been committed to disk.
> Also, the operations on file A are guaranteed to complete before or with
> operations on file B so fsync(B) will also cause the changes from A to
> be flushed to disk at the same time (this is guaranteed to complete before
> fsync(B) returns).

In order words, each fsync essentailly triggers a jbd commit, right?

-Junfeng

