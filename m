Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUDEInh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 04:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUDEInh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 04:43:37 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:3234 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263165AbUDEInf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 04:43:35 -0400
Date: Mon, 5 Apr 2004 10:43:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: mj@ucw.cz, jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405084328.GE28924@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040402182357.GB410@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 April 2004 20:23:58 +0200, Pavel Machek wrote:
> 
> > Then you link()...
> 
> INODE123 Usage count = 2, pointer to cowid 567
> COWID 567: Usage count = 3
> INODE124 Usage count = 2, pointer to cowid 567
> INODE125 Usage count = 2, pointer to cowid 567
> 
> Now, if I write to any inode with has cowid, data have to be copied,
> and pointer to cowid deleted from that inode .

Ok, you win.  Next time I get scare, I should ask you first. :)

In a single picture, links currently look like this:

Symlink		can point to inodes or cowlinks or hardlinks
Hardlink	can point to inodes or cowlinks
Cowlink		can point to inodes

I like it.

Not sure about the current count, but it looks like most people favor
the indirect approach now.

Jörn

-- 
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
