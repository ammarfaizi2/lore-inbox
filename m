Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTILBSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTILBSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:18:03 -0400
Received: from quechua.inka.de ([193.197.184.2]:48048 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261642AbTILBSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:18:00 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
In-Reply-To: <20030911171513.GA18399@matchmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19xcZR-0000e4-00@calista.inka.de>
Date: Fri, 12 Sep 2003 03:17:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030911171513.GA18399@matchmail.com> you wrote:
>> Well, in fact empty files do not need this block.
>> 
> 
> True.  Do you know if ext2/3 allocates the block even for empty files?  So
> if you create the file, it should be sparse until you write something to it,
> right?  Does the touch command do this?

At least it reserves an inode, and:

> touch /bla
> ls -lis bla
62    0 -rw-rw-r--    1 ecki     ecki            0 Sep 12 03:13 bla
> echo -n 1 >> /bla
> ls -lis bla
62    1 -rw-rw-r--    1 ecki     ecki            1 Sep 12 03:13 bla

looks like it reserves no data blocks until first written.

On XFS btw it starts with 4 blocks (2k?)

> ls -lis ~ecki/bla
7641042    4 -rw-rw-r--    1 ecki     ecki            1 Sep 12 03:13 bla

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
