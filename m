Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFIUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTFIUd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:33:28 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:11780 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261939AbTFIUdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:33:25 -0400
Date: Mon, 9 Jun 2003 13:46:55 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linus Torvalds <torvalds@transmeta.com>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030609134655.A10940@google.com>
References: <20030609065141.A9781@google.com> <Pine.LNX.4.44.0306090848080.12683-100000@home.transmeta.com> <16100.47243.421268.704120@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16100.47243.421268.704120@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Jun 09, 2003 at 06:40:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 06:40:43PM +0200, Trond Myklebust wrote:
> If people prefer 'rm -rf' correctness instead of unlinked-but-open,
> then we could do that by changing the behaviour of 'unlink' on a
> silly-deleted filed. Currently it returns EBUSY, but we could just as
> well have it complete the unlink, and mark the inode as being stale...

Actually, *currently* it unlinks. :-)  That's the problem.

/fc
