Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTEWC0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEWC0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 22:26:13 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8709 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263591AbTEWC0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 22:26:12 -0400
Date: Thu, 22 May 2003 19:42:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: torvalds@transmeta.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
Message-Id: <20030522194211.4191e473.akpm@digeo.com>
In-Reply-To: <20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
	<Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
	<20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 02:39:17.0307 (UTC) FILETIME=[816D10B0:01C320D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> POSIX can take a hike

aye.  But given a choice we should continue to do what 2.4 did.

I assume every foo_truncate() is doing

        inode->i_mtime = inode->i_ctime = CURRENT_TIME;
        mark_inode_dirty(inode);

and as Andries says, we can probably pull all that up to the VFS level.
