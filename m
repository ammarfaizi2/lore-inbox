Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUGCVhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUGCVhF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 17:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUGCVhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 17:37:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:34196 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265266AbUGCVhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 17:37:02 -0400
Date: Sat, 3 Jul 2004 14:35:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-Id: <20040703143558.5f2c06d6.akpm@osdl.org>
In-Reply-To: <20040703210407.GA11773@infradead.org>
References: <20040703202242.GA31656@MAIL.13thfloor.at>
	<20040703202541.GA11398@infradead.org>
	<20040703133556.44b70d60.akpm@osdl.org>
	<20040703210407.GA11773@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > > Actually the patch you reference above looks extremly bogus and should just
> > > be reverted instead.
> > 
> > Why is it "extremely bogus"?  I assume Olaf had a reason for wanting chmod
> > on procfs files?
> 
> Because it turns the question what permissions a procfs file has into
> a lottery game.  He only changes the incore inode owner and as soon as
> the inode is reclaimed the old ones return.

procfs inodes aren't reclaimable.

chrisw fixed this bug a couple of days ago.
