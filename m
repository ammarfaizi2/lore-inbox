Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVIRVEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVIRVEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVIRVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:04:42 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33185 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932201AbVIRVEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:04:41 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050918190714.GO19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
	 <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local>
	 <20050918171845.GL19626@ftp.linux.org.uk>
	 <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
	 <20050918190714.GO19626@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Sep 2005 22:30:26 +0100
Message-Id: <1127079026.8932.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would be very useful when e.g. tracking down improper uses of
> struct file, struct dentry, etc. - stuff that should always be
> allocated by one helper function.  Same goes for e.g. net_device -

Another useful trick here btw is to make such objects contain (when
debugging)

	void *magic_ptr;

which is initialised as foo->magic_ptr = foo;

That catches anyone copying them and tells you what got copied

