Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbUBPQ6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbUBPQ6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:58:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:45185 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265682AbUBPQ6t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:58:49 -0500
Subject: Re: 2.6.0, BUG() in JFS
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <9cf1xozw09t.fsf@rogue.ncsl.nist.gov>
References: <9cf1xozw09t.fsf@rogue.ncsl.nist.gov>
Content-Type: text/plain
Message-Id: <1076950722.4534.19.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:58:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-13 at 07:56, Ian Soboroff wrote:
> I got this oops this morning.  This machine is running 2.6.0... is
> this something that's been fixed already?

I've seen this reported before, but not with any regularity.  Either a
directory is somehow corrupted, or the directory grew beyond what JFS
was designed to handle (which shouldn't really happen).  Do you have any
directories that would have tens of thousands of entries or more?

What is the result of running fsck?

> 
> ...
> ERROR: (device sdb1): stack overrun in dtSearch!
> ERROR: (device sdb1): stack overrun in dtSearch!
> BUG at fs/jfs/jfs_dtree.c:3326 assert((btstack)->top != &((btstack)->stack[MAXTREEHEIGHT]))

The first two errors used to result in a BUG(), but they have been fixed
to fail more elegantly.  I still need to fix the third.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

