Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTDUSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTDUSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:55:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29457 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262001AbTDUSx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:53:28 -0400
Date: Mon, 21 Apr 2003 12:05:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421185806.GP10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0304211204440.9109-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Let's go for 32:32 internal and simply map upon mknod(2) and friends.

stat() too.

> On the syscall boundary.  End of problem.

I agree - that would make it always be obvious where the mapping happens, 
_and_ it cleanly avoids the alias issue internally, so that we don't have 
to play games in device drivers that want big ranges.

		Linus

