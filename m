Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUKITzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUKITzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUKITyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:54:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:3737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261657AbUKITxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:53:47 -0500
Date: Tue, 9 Nov 2004 11:53:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.10-rc1-mm4
Message-Id: <20041109115338.59d195ec.akpm@osdl.org>
In-Reply-To: <20041109161112.GA3921@suse.de>
References: <20041109074909.3f287966.akpm@osdl.org>
	<20041109161112.GA3921@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Tue, Nov 09 2004, Andrew Morton wrote:
> > +blk_sync_queue-updates.patch
> > 
> >  update an update to the md updates
> 
> I still don't think this is a good general export, it has very
> specialized use. For example, from the description it looks like this
> can be generally used on any block device and when it returns, we have
> synced the queue. This simply isn't true, there are absolutely no
> guarentees of that nature unless the block driver itself implements the
> __make_request() functionality and has taken proper precautions to
> prevent this already.

True.   So what do we do?  Grit our teeth and move it into MD?
