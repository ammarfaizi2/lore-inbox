Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUKOXyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUKOXyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbUKOXxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:53:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:23498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261658AbUKOXwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:52:34 -0500
Date: Mon, 15 Nov 2004 15:56:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm-pageout-throttling.patch: hanging in
 throttle_vm_writeout/blk_congestion_wait
Message-Id: <20041115155639.744bfc67.akpm@osdl.org>
In-Reply-To: <20041115231705.GE6654@m.safari.iki.fi>
References: <20041115012620.GA5750@m.safari.iki.fi>
	<Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain>
	<20041115223709.GD6654@m.safari.iki.fi>
	<200411151451.21671.ryan@spitfire.gotdns.org>
	<20041115231705.GE6654@m.safari.iki.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please always do reply-to-all when working with kernel people.

Sami Farin <7atbggg02@sneakemail.com> wrote:
>
> > swapon /path/to/file/on/reiserfs
> > 
> > This allows the kernel to perform certain optimizations and removes the 
> > overhead of the loopback device.
> 
> It also removes encryption, which I wish to have.

The dm-crypt driver should be able to do this, and it doesn't have
low-on-memory deadlock problems.

(Not that I'm convinced that this was a low-on-memory deadlock - that
wasn't obvious from the traces).
