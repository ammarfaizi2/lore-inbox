Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUFYV5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUFYV5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266873AbUFYV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:57:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:55949 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266871AbUFYV5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:57:45 -0400
Date: Fri, 25 Jun 2004 15:00:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
Message-Id: <20040625150021.3f50350b.akpm@osdl.org>
In-Reply-To: <6uhdsz3jud.fsf@zork.zork.net>
References: <40DB605D.6000409@comcast.net>
	<6uhdsz3jud.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> wrote:
>
> I seem to remember somebody, I think maybe Andrew Morton, suggesting
> that a no-journal mode be added to ext3 so that ext2 could be removed.
> I can't find the message in question right now, though.

I think it could be done, mainly as a kernel-space-saving exercise.  But
the two filesystems are quite different nowadays.

ext2 uses per-inode pagecache for directories, ext3 uses blockdev
pagecache.  The truncate algorithms are significantly different. Other stuff.

Much pain, little gain.
