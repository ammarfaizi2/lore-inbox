Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUBRBqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUBRBqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:46:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:57509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266619AbUBRBqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:46:11 -0500
Date: Tue, 17 Feb 2004 17:47:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.3-rc2-mm1] address_space_serialize_writeback patch
Message-Id: <20040217174755.2d870b40.akpm@osdl.org>
In-Reply-To: <1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	<20040213143836.0a5fdabb.akpm@osdl.org>
	<1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
	<20040213154815.42e74cb5.akpm@osdl.org>
	<1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Here is the patch that does what you suggested.  It adds a rwsema to
> the address_space and do_writepages() uses it serialize writebacks.

Did you verify that we actually _need_ the semaphore?  I seem to recall that
it was a "try this, otherwise add the semaphore" thing.  Where "this" was "always
remark the page dirty".

Probably we do need the semaphore, but I'd just like to check that you checked ;)

