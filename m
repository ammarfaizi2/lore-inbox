Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTIYNhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTIYNhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:37:13 -0400
Received: from zork.zork.net ([64.81.246.102]:3218 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261232AbTIYNhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:37:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Data writting over the quota chage inote time
References: <fc5f185ffdd49f6f4444747a24368d79@www4.mail.post.cz>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 25 Sep 2003 14:37:08 +0100
In-Reply-To: <fc5f185ffdd49f6f4444747a24368d79@www4.mail.post.cz> (Youza
 Youzovic's message of "Thu, 25 Sep 2003 15:28:19 +0200 (CEST)")
Message-ID: <6uad8toupn.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Youza Youzovic" <youza@post.cz> writes:

> echo "s" >> test; stat test 
> File: "test"
> Size: 204800 Blocks: 408 IO Block: 
> 121234234 Regular File
> Device: 811h/2065d Inode: 6300 Links: 1 
> Access: (0644/-rw-r--r--) Uid: (1010/test) Gid:(0/root)
> Access: Wed Aug 13 16:10:21 2003
> Modify: Wed Aug 13 16:14:38 2003
> Change: Wed Aug 13 16:14:38 2003
>
> the size is not change - this is OK !!
> But Modify, and Change time is modified !!!

ctime is the inode change time; it has nothing to do with quotas.  In
your example above, you wrote some data to a file, which resulted in
some of the inode's fields being updated, which resulted in the inode
change time being updated.

