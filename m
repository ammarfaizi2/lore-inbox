Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUCJTxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUCJTxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:53:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:25474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262805AbUCJTxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:53:44 -0500
Date: Wed, 10 Mar 2004 11:55:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-Id: <20040310115545.16cb387f.akpm@osdl.org>
In-Reply-To: <20040310124507.GU4949@suse.de>
References: <20040310124507.GU4949@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Here's a first cut at killing global plugging of block devices to reduce
> the nasty contention blk_plug_lock caused. This introduceds per-queue
> plugging, controlled by the backing_dev_info.

This is such an improvement over what we have now it isn't funny.

Ken, the next -mm is starting to look like linux-3.1.0 so I think it
would be best if you could benchmark Jens's patch against 2.6.4-rc2-mm1.
