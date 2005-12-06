Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVLFWTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVLFWTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVLFWTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:19:15 -0500
Received: from ozlabs.org ([203.10.76.45]:25012 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932643AbVLFWTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:19:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
Date: Wed, 7 Dec 2005 09:19:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
In-Reply-To: <1133905298.8027.13.camel@localhost>
References: <20051206035220.097737000@localhost>
	<200512061118.19633.arnd@arndb.de>
	<1133869108.7968.1.camel@localhost>
	<200512061949.33482.arnd@arndb.de>
	<1133895947.3279.4.camel@localhost>
	<17301.65082.251692.675360@cargo.ozlabs.ibm.com>
	<1133905298.8027.13.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg writes:

> I think the fact that it is highly architecture specific is relevant. I
> have no way of testing spufs changes except on cell, no? And if I am
> developing on a cell, I probably will notice it in arch/ all the same.
> So I don't quite buy your the maintenace argument.

Think about someone changing the VFS layer interface and fixing up all
the filesystems to accommodate that change.  That person is doing some
of your work for you, so you want to make it easy for him/her to find
your filesystem.  That's the sort of thing I was referring to as
maintenance.

As for changes on the cell-specific side, the people doing those
changes will know where to find it, so it isn't a problem having it in
fs/.

Having it in fs/ also means that it is more likely that people
familiar with VFS internals will look through your code and comment on
it.  I know that can be painful in the short term, but in the long
term it will lead to better code.

Paul.
